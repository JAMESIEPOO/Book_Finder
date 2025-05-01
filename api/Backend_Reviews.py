from flask import Blueprint, render_template, request, jsonify, session
import psycopg2
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

reviews_api = Blueprint('reviews_api', __name__, url_prefix='/reviews')

def connect_db():
    return psycopg2.connect(
        dbname= 'Book_FinderV4',
        user= 'postgres',
        password= 'password',
        host='localhost',
        port='5432'
    )

@reviews_api.route('/', methods=['GET'])
def view_reviews():
    user_id = session.get('user_id', 1)
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('''
        SELECT r."reviewID", b."title", r."rating", r."reviewText"
        FROM "Review" r
        JOIN "Book" b ON r."bookID" = b."bookID"
        WHERE r."userID" = %s
    ''', (user_id,))

    reviews = cursor.fetchall()
    conn.close()

    review_list = [{'reviewID': r[0], 'book_title': r[1], 'rating': r[2], 'reviewText': r[3]} for r in reviews]
    return render_template('usr_review.html', reviews=review_list)


@reviews_api.route('/<int:review_id>/update', methods=['POST'])
def update_review(review_id):
    data = request.get_json()
    updated_text = data.get('reviewText')  # <-- match frontend key

    if not updated_text:
        return jsonify({'error': 'No review text provided'}), 400

    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('UPDATE "Review" SET "reviewText" = %s WHERE "reviewID" = %s', (updated_text, review_id))
    conn.commit()
    conn.close()

    return jsonify({'message': 'Review updated successfully'})

@reviews_api.route('/<int:review_id>/delete', methods=['DELETE'])
def delete_review(review_id):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute('DELETE FROM "Review" WHERE "reviewID" = %s', (review_id,))
    conn.commit()
    conn.close()

    return jsonify({'message': 'Review deleted successfully'})

