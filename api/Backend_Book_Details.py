from flask import Blueprint, render_template, request
import psycopg2
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Create Blueprint
book_detail_api = Blueprint('book_detail_api', __name__, url_prefix='/book')

def connect_db():
    return psycopg2.connect(
        dbname=os.getenv('DB_NAME'),
        user=os.getenv('USER_DB', 'postgres'),
        password=os.getenv('PASSWORD_DB', 'password'),
        host='localhost',
        port='5432'
    )

@book_detail_api.route('/<int:book_id>')
def book_detail(book_id):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('''
        SELECT 
            b."bookID",
            b."title",
            a."authorname",
            b."date published",
            g."genreName",
            b."rating",
            p."publisherName"
        FROM "Book" b
        LEFT JOIN "Author" a ON b."authorID" = a."authorID"
        LEFT JOIN "Genre" g ON b."genreID" = g."genreID"
        LEFT JOIN "Publisher" p ON b."publisherID" = p."publisherID"
        WHERE b."bookID" = %s
    ''', (book_id,))

    book = cursor.fetchone()
    conn.close()

    if not book:
        return "Book not found", 404

    book_details = {
        "bookID": book[0],
        "title": book[1],
        "authorname": book[2],
        "date_published": book[3].isoformat() if book[3] else None,
        "genreName": book[4],
        "rating": float(book[5]) if book[5] is not None else None,
        "publisherName": book[6]
    }

    return render_template('book_detail.html', book=book_details)

@book_detail_api.route('/add_to_favorites', methods=['POST'])
def add_to_favorites():
    book_id = request.form.get('book_id')

    if not book_id:
        return "No book selected", 400

    user_id = 1  # Temporary hardcoded user ID

    conn = connect_db()
    cursor = conn.cursor()

    # Check if already favorited
    cursor.execute('SELECT * FROM "Favorites" WHERE "userID" = %s AND "bookID" = %s', (user_id, book_id))
    existing = cursor.fetchone()

    if existing:
        conn.close()
        return render_template('already_in_favorites.html')

    # Insert into Favorites table
    cursor.execute('INSERT INTO "Favorites" ("userID", "bookID") VALUES (%s, %s)', (user_id, book_id))
    conn.commit()
    conn.close()

    return render_template('added_to_favorites.html')
