from flask import Flask, request, jsonify, render_template, Blueprint, redirect, url_for
from flask_jwt_extended import create_access_token
import psycopg2
import os
import bcrypt
from dotenv import dotenv_values
from datetime import timedelta

# Initialize Blueprint for authentication routes
auth_app = Blueprint('auth_app', __name__, template_folder='../templates')
main_app = Blueprint('main_app', __name__, template_folder='../templates')

# Function to connect to the database
def connect_db():
    return psycopg2.connect(
        dbname=os.getenv('DB_NAME'),
        user= os.getenv('USER_DB','postgres'),
        password= os.getenv('PASSWORD_DB','password'),
        host = 'localhost',
        port = '5432',
    )

# Route for Home Page
@auth_app.route('/')
def home():
    return render_template('index.html')


# Route for rendering the signup page
@auth_app.route('/signup', methods=['GET'])
def signup_page():
    return render_template('signup.html')

# Route for handling signup (API call)
@auth_app.route('/signup', methods=['POST'])
def signup():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    email = data.get('email')

    # Hash the password
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password.encode(), salt)

    conn = connect_db()
    cursor = conn.cursor()

    # Check if the email already exists
    cursor.execute('SELECT email FROM "User" WHERE email = %s', (email,))
    existing_user = cursor.fetchone()
    if existing_user:
        return jsonify({"message": "Email already in use"}), 400

    # Insert new user into the database with hashed password
    cursor.execute('INSERT INTO "User" (username, email, password) VALUES (%s, %s, %s)',
                   (username, email, hashed_password.decode()))  # Store as string
    conn.commit()
    conn.close()

    return jsonify({"message": "User registered successfully!"}), 201

# Route for rendering the login page
@auth_app.route('/login', methods=['GET'])
def login_page():
    return render_template('login.html')

# Route for handling login (API call)
@auth_app.route('/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    conn = connect_db()
    cursor = conn.cursor()

    # Query the database for user email and password hash
    cursor.execute('SELECT "userID", "password" FROM "User" WHERE email = %s', (email,))
    user = cursor.fetchone()
    conn.close()

    # Check if the user exists and if the password matches the hashed password
    if not user or not bcrypt.checkpw(password.encode('utf-8'), user[1].encode('utf-8')):
        return jsonify({"message": 'Invalid credentials'}), 401

    # Generate JWT access token
    access_token = create_access_token(identity={"email": email})

    return jsonify({
        "message": "Login successful",
        "access_token": access_token
    })

# Add Route for Search Page
@auth_app.route('/search')
def search_page():
    return render_template('search_page.html')

# Add Route for Book Detail Page
@auth_app.route('/book/<int:book_id>')
def book_detail_page(book_id):
    return render_template('Book detail page.html', book_id=book_id)


if __name__ == '__main__':
    app.run(debug=True)