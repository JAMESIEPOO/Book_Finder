from flask import Blueprint, render_template, request, session, redirect
import psycopg2
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

book_detail_api = Blueprint('book_detail_api', __name__, url_prefix='/book')

def connect_db():
    return psycopg2.connect(
        dbname= 'Book_FinderV4',
        user= 'postgres',
        password= 'password',
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
    user_id = session.get('user_id', 1)
    book_id = request.form.get('book_id')

    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('SELECT 1 FROM "Favorites" WHERE "userID" = %s AND "bookID" = %s', (user_id, book_id))
    existing = cursor.fetchone()

    if existing:
        conn.close()
        return render_template('already_in_favorites.html')

    cursor.execute('INSERT INTO "Favorites" ("userID", "bookID") VALUES (%s, %s)', (user_id, book_id))
    conn.commit()
    conn.close()

    return render_template('added_to_favorites.html')

@book_detail_api.route('/add_review', methods=['POST'])
def add_review():
    user_id = session.get('user_id', 1)
    book_id = request.form.get('book_id')

    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('SELECT 1 FROM "Review" WHERE "userID" = %s AND "bookID" = %s', (user_id, book_id))
    existing_review = cursor.fetchone()

    if existing_review:
        conn.close()
        return redirect('/reviews')

    cursor.execute('''
        INSERT INTO "Review" ("userID", "bookID", "rating", "reviewText")
        VALUES (%s, %s, %s, %s)
    ''', (user_id, book_id, 5, ''))

    conn.commit()
    conn.close()

    return redirect('/reviews')
