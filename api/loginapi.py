from flask import Flask, request, jsonify, render_template, Blueprint
from flask_jwt_extended import create_access_token
import psycopg2
import os
from dotenv import dotenv_values
from datetime import timedelta

# Create Flask app and configure JWT
app = Flask(__name__)

app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(minutes=60)
app.config['JWT_REFRESH_TOKEN_EXPIRES'] = timedelta(days=7)
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY', 'your-secret-key')

# Initialize Blueprint for authentication routes
auth_app = Blueprint('auth_app', __name__)

# Function to connect to the database
def connect_db():
    return psycopg2.connect(
        dbname = 'Book_Finder_V2',
        user= os.getenv('USER_DB','postgres'),
        password= os.getenv('PASSWORD_DB','password'),
        host = 'localhost',
        port = '5432',
    )

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

    conn = connect_db()
    cursor = conn.cursor()

    # Check if the email already exists
    cursor.execute('SELECT email FROM "User" WHERE email = %s', (email,))
    existing_user = cursor.fetchone()
    if existing_user:
        return jsonify({"message": "Email already in use"}), 400

    # Insert new user into the database without password hashing (for testing)
    cursor.execute('INSERT INTO "User" (username, email, password) VALUES (%s, %s, %s)',
                   (username, email, password))
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

    # Query the database for user email and password (no hashing for now)
    cursor.execute('SELECT "userID", "password" FROM "User" WHERE email = %s', (email,))
    user = cursor.fetchone()
    conn.close()

    # Check if the user exists and if the password matches
    if not user or user[1] != password:
        return jsonify({"message": 'Invalid credentials'}), 401

    # Generate JWT access token
    access_token = create_access_token(identity={"email": email})

    return jsonify({
        "message": "Login successful",
        "access_token": access_token
    })

# Register the auth blueprint to the main app
app.register_blueprint(auth_app, url_prefix='/auth')

if __name__ == '__main__':
    app.run(debug=True)
