from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
from flask_socketio import SocketIO
from uuid import uuid4
import os
import json
import mysql.connector
import bcrypt

clients = []
users = {}

app = Flask(__name__)
CORS(app)
socketio = SocketIO(app, cors_allowed_origins='*')

database = mysql.connector.connect(
  host=os.environ['DB_HOST'],
  user=os.environ['DB_USER'],
  password=os.environ['DB_PASSWORD'],
  database="cs4471"
)

cursor = database.cursor()

@app.route("/signup", methods=["POST"])
def signup():
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(request.json["password"].encode('utf8'), salt)
    token = str(uuid4())
    query = ("INSERT INTO user (email, password, token) VALUES (%s, %s, %s)")
    value = (request.json["email"], hashed_password, token)
    cursor.execute(query, value)

    database.commit()

    response = {
        "token": None
    }

    if cursor.rowcount == 1:
        response["token"] = token
        return jsonify(response)
    else:
        return jsonify(response)

@app.route("/login", methods=["POST"])
def login():
    query = ("SELECT * FROM user WHERE email = %s")
    value = (request.json["email"], )
    cursor.execute(query, value)

    result = cursor.fetchall()

    response = {
        "token": None
    }

    if len(result) == 1:
        id = result[0][0]
        hashed_password = result[0][2]

        if bcrypt.checkpw(request.json["password"].encode('utf8'), hashed_password.encode('utf8')):
            token = str(uuid4())
            query = ("UPDATE user SET token = %s WHERE id = %s")
            value = (token, id, )
            cursor.execute(query, value)
            database.commit()
            if cursor.rowcount == 1:
                response["token"] = token
                return jsonify(response)
            else:
                return jsonify(response)
        else:
            return jsonify(response)
    else:
        return jsonify(response)

@socketio.on('connect')
def connect(message):
    clients.append(request.sid)

@socketio.on('message')
def message(message):
    data = json.loads(message)
    if data["type"] == "connect" and request.sid in clients:
        id = token_to_id(data["token"])
        users[id] = request.sid
    
    print(users)
    
# authentication middleware:
def token_to_id(token):
    query = ("SELECT id FROM user WHERE token = %s")
    value = (token, )
    cursor.execute(query, value)

    result = cursor.fetchall()
    
    if len(result) == 1:
        return result[0][0]
    else:
        return None

if __name__ == '__main__':
    socketio.run(app)
    cursor.close()
    database.close()
