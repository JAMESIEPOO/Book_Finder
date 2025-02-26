from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from werkzeug.security import generate_password_hash, check_password_hash
import psycopg2, os
from config import JWT_SECRET_KEY
from dotenv import dotenv_values
from datetime import timedelta

app = Flask(__name__)

app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(minutes=60)  
app.config['JWT_REFRESH_TOKEN_EXPIRES'] = timedelta(days=7)  
app.config['JWT_SECRET_KEY'] = (JWT_SECRET_KEY)

jwt = JWTManager(app)

def connect_db():
    return psycopg2.connect(
        dbname = 'Book_Finder_V2',
        #replace env variables with your postgres username and password to test
            user= os.getenv('USER_DB','postgres'),
            password= os.getenv('PASSWORD_DB','password'),
            host = 'localhost',
            port = '5432',
    )



@app.route('/signup', methods = ['POST'])
def signup():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    email = data.get('email')

    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('INSERT INTO Users (username,email,password) VALUES (%s %s %s)', (username,email,password))
    conn.commit()
    conn.close()

    return jsonify({"message": "User registered successfully!"}), 201




@app.route('/login', methods = ['POST'])
def login():
    data = request.json()
    password = data.get('password')
    email = data.get('email')

    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('SELECT userID, password FROM Users WHERE email = %s',email)

    emaildata = cursor.fetchone()
    conn.close()

    if not emaildata or emaildata[1] != password:
        return jsonify({"message": 'Invalid'}),401
    
    access_token = create_access_token(identity={"email" : email})

    return jsonify({
        "message" : "Login successs",
        "access_token" : access_token
    })

if __name__ == '__main__':
    app.run(debug = True)


