from flask import Blueprint, jsonify
import os
import psycopg2
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Create a Blueprint for the API
api_app = Blueprint('api', __name__)

def connect_db():
    return psycopg2.connect(
        dbname='Book_Finder_V2',
        user=os.getenv('USER_DB', 'postgres'),
        password=os.getenv('PASSWORD_DB', 'password'),
        host='localhost',
        port='5432',
    )

# Define API routes within the Blueprint
@api_app.route('/authors', methods=['GET'])
def get_authors():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM public."Author"')
    authors = cursor.fetchall()
    cursor.close()
    conn.close()
    author_list = [{"id": row[0], "name": row[1]} for row in authors]
    return jsonify(author_list)

@api_app.route('/publisher', methods=['GET'])
def get_publisher():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM public."Publisher"')
    publishers = cursor.fetchall()
    cursor.close()
    conn.close()
    publisher_list = [{"id": row[0], "name": row[1]} for row in publishers]
    return jsonify(publisher_list)

@api_app.route('/book', methods=['GET'])
def get_book():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM public."Book"')
    book = cursor.fetchall()
    cursor.close()
    conn.close()
    book_list = [{"id": row[0], "title": row[1]} for row in book]
    return jsonify(book_list)

@api_app.route('/preferences', methods=['GET'])
def get_preferences():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM public."Preferences"')
    preferences = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(preferences)

@api_app.route('/review', methods=['GET'])
def get_reviews():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM public."Review"')
    review = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(review)
