from flask import Flask, jsonify
import os
import psycopg2

from dotenv import load_dotenv



app = Flask(__name__)
def connect_db():
    return psycopg2.connect(
        dbname = 'Book_Finder_V2',
        #replace env variables with your postgres username and password to test
            user= os.getenv('USER_DB','postgres'),
            password= os.getenv('PASSWORD_DB','password'),
            host = 'localhost',
            port = '5432',
    )

conn = connect_db()
cursor = conn.cursor()
#authors
@app.route('/authors', methods =['GET'])
def get_authors():
    cursor.execute('SELECT * FROM public."Author"')
    authors = cursor.fetchall()
    conn.close()
    author_list = [{"id": row[0], "name": row[1]} for row in authors]  
    return jsonify(author_list)

#publisher
@app.route('/publisher', methods = ['GET'])
def get_publisher():
    cursor.execute('SELECT * FROM public."Publisher"')
    publishers = cursor.fetchall()
    conn.close()
    publisher_list = [{"id": row[0], "name": row[1]} for row in publishers]  
    return jsonify(publisher_list)

#books
@app.route('/book', methods = ['GET'])
def get_book():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM public."Book"')
    book = cursor.fetchall()
    conn.close()
    book_list = [{"id": row[0], "title": row[1]} for row in book]  
    return jsonify(book_list)

#preferences
@app.route('/preferences', methods = ['GET'])
def get_preferences():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM public."Preferences"')
    preferences = cursor.fetchall()
    conn.close()
    return jsonify(preferences)

#review
@app.route('/review', methods = ['GET'])
def get_reviews():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM public."Review"')
    review = cursor.fetchall()
    conn.close()

    return jsonify(review)

if __name__ == '__main__':
    app.run(debug = True)