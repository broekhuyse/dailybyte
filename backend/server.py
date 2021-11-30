from flask import Flask, request, jsonify
from flask_cors import CORS
from uuid import uuid4
import mysql.connector
import bcrypt

app = Flask(__name__)
CORS(app)

database = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="cs4471"
)

cursor = database.cursor()

@app.route("/", methods=["GET"])
def index():
    return "Hello World"

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

# authentication middleware:
def authentication():
    pass

if __name__ == '__main__':
    app.run()
    cursor.close()
    database.close()
