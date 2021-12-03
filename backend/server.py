from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
from flask_socketio import SocketIO, emit
from uuid import uuid4
import os
import json
import mysql.connector
import bcrypt

import news
import covid

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

@app.route("/subscribe", methods=["POST"])
def subscribe():
    user_id = token_to_id(request.json["token"])
    service_id = request.json["service"]
    print(user_id)
    print(service_id)
    query = ("INSERT INTO subscription (user_id, service_id) VALUES (%s, %s)")
    value = (user_id, service_id, )
    cursor.execute(query, value)
    database.commit()
    if cursor.rowcount == 1:
        if service_id == "covid":
            publish_to_subscriber_with_one_subscription(service_id, user_id, covid.toJson())
        elif service_id == "news":
            print(news.toJson())
            publish_to_subscriber_with_one_subscription(service_id, user_id, news.toJson())
        return ""
    else:
        return ""


@socketio.on('connect')
def connect(message):
    clients.append(request.sid)

@socketio.on('initial')
def initial(data):
    if request.sid in clients:
        id = token_to_id(data["token"])
        users[id] = request.sid
        subscriptions = get_all_subscription(id)
        services = get_all_services()
        response = {
            "subscriptions": subscriptions,
            "services": services
        }
        emit("services", response, room=request.sid)
        publish_to_subscriber_with_all_subscription(id)
    
def get_all_services():
    query = ("SELECT service_id FROM service")
    cursor.execute(query)
    result = [item[0] for item in cursor.fetchall()]

    return result

def get_all_subscription(user_id):
    query = ("SELECT service_id FROM subscription WHERE user_id = %s")
    value = (user_id, )
    cursor.execute(query, value)

    result = [item[0] for item in cursor.fetchall()]
    return result

def get_all_subscribers(service_id):
    query = ("SELECT user_id FROM subscription WHERE service_id = %s")
    value = (service_id, )
    cursor.execute(query, value)

    result = [item[0] for item in cursor.fetchall()]
    return result

def publish_to_subscribers(service_id, data):
    user_ids = get_all_subscribers(service_id)
    for i in range(0, len(user_ids)):
        if user_ids[i] in users:
            print(data)
            socketio.emit(service_id, data, room=users[user_ids[i]])

def publish_to_subscriber_with_one_subscription(service_id, user_id, data):
     if user_id in users:
        socketio.emit(service_id, data, room=users[user_id])

def publish_to_subscriber_with_all_subscription(user_id):
    subscriptions = get_all_subscription(user_id)
    for i in range(0, len(subscriptions)):
        if subscriptions[i] == "covid":
                publish_to_subscriber_with_one_subscription(subscriptions[i], user_id, covid.toJson())
        elif subscriptions[i] == "news":
            publish_to_subscriber_with_one_subscription(subscriptions[i], user_id, news.toJson())

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
