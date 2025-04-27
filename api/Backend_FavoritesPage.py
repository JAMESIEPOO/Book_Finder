from flask import Blueprint, render_template, request, redirect, url_for, session
import psycopg2
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

favorites_api = Blueprint('favorites_api', __name__, url_prefix='/favorites')

def connect_db():
    return psycopg2.connect(
        dbname=os.getenv('DB_NAME'),
        user=os.getenv('USER_DB', 'postgres'),
        password=os.getenv('PASSWORD_DB', 'password'),
        host='localhost',
        port='5432'
    )

@favorites_api.route('/', methods=['GET'])
def view_favorites():
    user_id = session.get('user_id', 1)  # Hardcoded user_id=1 for now
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('''
        SELECT b."bookID", b."title", a."authorname"
        FROM "Favorites" f
        JOIN "Book" b ON f."bookID" = b."bookID"
        LEFT JOIN "Author" a ON b."authorID" = a."authorID"
        WHERE f."userID" = %s
    ''', (user_id,))

    favorites = cursor.fetchall()
    conn.close()

    favorite_books = [{'bookID': f[0], 'title': f[1], 'authorname': f[2]} for f in favorites]
    return render_template('usr_favorites.html', favorites=favorite_books)

@favorites_api.route('/remove/<int:book_id>', methods=['POST'])
def remove_favorite(book_id):
    user_id = session.get('user_id', 1)
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('DELETE FROM "Favorites" WHERE "userID" = %s AND "bookID" = %s', (user_id, book_id))
    conn.commit()
    conn.close()

    return redirect(url_for('favorites_api.view_favorites'))
