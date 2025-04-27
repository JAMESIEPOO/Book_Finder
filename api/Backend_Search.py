# Backend_Search.py

from flask import Blueprint, request, jsonify
import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

search_api = Blueprint('search_api', __name__, url_prefix='/search')

def connect_db():
    return psycopg2.connect(
        dbname=os.getenv('DB_NAME'),
        user=os.getenv('USER_DB', 'postgres'),
        password=os.getenv('PASSWORD_DB', 'password'),
        host='localhost',
        port='5432',
    )

@search_api.route('/', methods=['GET'])
def search_books():
    query = request.args.get('query', '').strip()
    filter_type = request.args.get('filter', 'all').lower()

    if not query:
        return jsonify({"error": "Search query is required."}), 400

    try:
        conn = connect_db()
        cursor = conn.cursor()

        base_query = '''
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
        '''

        if filter_type == 'title':
            cursor.execute(base_query + ' WHERE b."title" ILIKE %s', (f'%{query}%',))
        elif filter_type == 'author':
            cursor.execute(base_query + ' WHERE a."authorname" ILIKE %s', (f'%{query}%',))
        elif filter_type == 'date':
            cursor.execute(base_query + ' WHERE b."date published"::text LIKE %s', (f'%{query}%',))
        else:
            cursor.execute(base_query + '''
                WHERE b."title" ILIKE %s 
                OR a."authorname" ILIKE %s 
                OR b."date published"::text LIKE %s
            ''', (f'%{query}%', f'%{query}%', f'%{query}%'))

        rows = cursor.fetchall()
        conn.close()

        results = []
        for row in rows:
            results.append({
                "bookID": row[0],
                "title": row[1],
                "authorname": row[2],
                "date_published": row[3].isoformat() if row[3] else None,
                "genreName": row[4],
                "rating": float(row[5]) if row[5] is not None else None,
                "publisherName": row[6]
            })

        return jsonify(results), 200

    except Exception as e:
        print("Error in search:", e)
        return jsonify({"error": str(e)}), 500
