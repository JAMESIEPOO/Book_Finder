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
        dbname=os.getenv('DB_NAME'),
        user=os.getenv('USER_DB', 'postgres'),
        password=os.getenv('PASSWORD_DB', 'password'),
        host='localhost',
        port='5432',
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

@auth_app.route('/book/<int:book_id>')
def book_detail_page(book_id):
    return render_template('Book detail page.html', book_id=book_id)

@auth_app.route('/favorites/add/<int:book_id>', methods=['POST'])
def add_to_favorites(book_id):
    if 'user_id' not in session:
        return redirect(url_for('auth_app.login_page'))

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO favorites (user_id, book_id)
        VALUES (%s, %s)
        ON CONFLICT DO NOTHING
    ''', (session['user_id'], book_id))
    conn.commit()
    conn.close()
    return redirect(url_for('auth_app.book_detail_page', book_id=book_id))

@auth_app.route('/wishlist/remove/<int:book_id>', methods=['POST'])
def remove_from_wishlist(book_id):
    if 'user_id' not in session:
        return redirect(url_for('auth_app.login_page'))

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('''
        DELETE FROM wishlist
        WHERE user_id = %s AND book_id = %s
    ''', (session['user_id'], book_id))
    conn.commit()
    conn.close()
    return redirect(url_for('auth_app.usr_favorites.html'))

@auth_app.route('/favorites')
def usr_favorites():
    if 'user_id' not in session:
        return redirect(url_for('auth_app.login_page'))

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT b.book_id, b.title, b.author, b.cover_url
        FROM books b
        JOIN wishlist w ON b.book_id = w.book_id
        WHERE w.user_id = %s
    ''', (session['user_id'],))
    rows = cursor.fetchall()
    conn.close()

    favorites = [
        {'book_id': row[0], 'title': row[1], 'author': row[2], 'cover_url': row[3]}
        for row in rows
    ]
    return render_template('usr_favorites.html', favorites=favorites)