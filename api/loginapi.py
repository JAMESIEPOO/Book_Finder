from flask import Blueprint, request, jsonify, render_template, redirect, url_for, session
import psycopg2
import os
import bcrypt
from dotenv import load_dotenv
from flask_jwt_extended import create_access_token
from datetime import timedelta

load_dotenv()

auth_app = Blueprint('auth_app', __name__, template_folder='../templates')

def connect_db():
    return psycopg2.connect(
        dbname= 'Book_FinderV4',
        user= 'postgres',
        password= 'password',
        host='localhost',
        port='5432'
    )

@auth_app.route('/')
def home():
    return render_template('index.html')

@auth_app.route('/signup', methods=['GET'])
def signup_page():
    return render_template('signup.html')

@auth_app.route('/signup', methods=['POST'])
def signup():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    email = data.get('email')

    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password.encode(), salt)

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT email FROM "User" WHERE email = %s', (email,))
    existing_user = cursor.fetchone()

    if existing_user:
        return jsonify({"message": "Email already in use"}), 400

    cursor.execute('INSERT INTO "User" (username, email, password) VALUES (%s, %s, %s)',
                   (username, email, hashed_password.decode()))
    conn.commit()
    conn.close()

    return jsonify({"message": "User registered successfully!"}), 201

@auth_app.route('/login', methods=['GET'])
def login_page():
    return render_template('login.html')

@auth_app.route('/login', methods=['POST'], endpoint='login')
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT "userID", "username", "password" FROM "User" WHERE email = %s', (email,))
    user = cursor.fetchone()
    conn.close()

    if not user or not bcrypt.checkpw(password.encode('utf-8'), user[2].encode('utf-8')):
        return jsonify({"message": "Invalid credentials"}), 401

    session['user_id'] = user[0]
    session['username'] = user[1]
    session['email'] = email

    access_token = create_access_token(identity={"email": email})
    return jsonify({"message": "Login successful", "access_token": access_token}), 200

@auth_app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('auth_app.login_page'))

@auth_app.route('/search')
def search_page():
    return render_template('search_page.html')
