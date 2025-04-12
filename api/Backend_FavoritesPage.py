from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from your_application import db 
from your_application.models import Book, Favorite, Review

api = Blueprint('api', __name__, url_prefix='/api')

@api.route('/favorites', methods=['GET'])
@jwt_required()
def get_favorites():
    """
    Retrieves the current user's favorites and returns the data as JSON.
    """
    user_id = get_jwt_identity()
    
    favorites = Favorite.query.filter_by(user_id=user_id).all()
    favorites_data = []
    for fav in favorites:
        # Retrieve the book details for each favorite
        book = Book.query.get(fav.book_id)
        # Optionally retrieve an associated review for this book
        review = Review.query.filter_by(user_id=user_id, book_id=fav.book_id).first()
        favorites_data.append({
            'book_id': book.id,
            'title': book.title,
            'review': review.content if review else None
        })
    
    return jsonify({
        "status": "success",
        "favorites": favorites_data
    }), 200

@api.route('/favorites/add', methods=['POST'])
@jwt_required()
def add_to_favorites():
    """
    Adds a book to the current user's favorites via a JSON API.
    
    Expects a JSON payload with a 'book_id' key, for example:
    
        { "book_id": 123 }
    """
    user_id = get_jwt_identity()
    
    # Expecting JSON data; you can also use request.form if sending form data
    data = request.get_json()
    if not data or 'book_id' not in data:
        return jsonify({
            "status": "error",
            "message": "No book ID provided."
        }), 400

    book_id = data['book_id']
    book = Book.query.get(book_id)
    
    if not book:
        return jsonify({
            "status": "error",
            "message": "Book not found."
        }), 404

    # Check if the book is already in favorites
    existing_favorite = Favorite.query.filter_by(user_id=user_id, book_id=book_id).first()
    if existing_favorite:
        return jsonify({
            "status": "info",
            "message": "This book is already in your favorites."
        }), 200

    new_favorite = Favorite(user_id=user_id, book_id=book_id)
    db.session.add(new_favorite)
    db.session.commit()

    return jsonify({
        "status": "success",
        "message": "Book added to your favorites!"
    }), 201

@api.route('/favorites/remove/<int:book_id>', methods=['DELETE'])
@jwt_required()
def remove_from_favorites(book_id):
    """
    Removes a specified book from the current user's favorites and returns a JSON response.
    """
    user_id = get_jwt_identity()
    favorite = Favorite.query.filter_by(user_id=user_id, book_id=book_id).first()
    
    if not favorite:
        return jsonify({
            "status": "error",
            "message": "Favorite not found."
        }), 404

    db.session.delete(favorite)
    db.session.commit()

    return jsonify({
        "status": "success",
        "message": "Book removed from your favorites."
    }), 200
