# auth_app_routes.py
from flask import Blueprint, render_template, request, jsonify, abort
from flask_jwt_extended import jwt_required, get_jwt_identity
from app import db
from app.models import User, Book, Review, Favorite

auth_app = Blueprint('auth_app', __name__, template_folder='templates')

@auth_app.route('/profile')
@jwt_required()
def profile():
    """Render the user profile page"""
    username = get_jwt_identity()
    return render_template('profile.html', username=username)

@auth_app.route('/favorites')
@jwt_required()
def usr_favorites():
    """Render the user's wishlist/favorites"""
    user = User.query.filter_by(username=get_jwt_identity()).first_or_404()
    favorites = [fav.book for fav in user.favorites]
    return render_template('favorites.html', favorites=favorites)

@auth_app.route('/reviews', methods=['GET'])
@jwt_required()
def usr_reviews():
    """Render the user's book reviews"""
    user = User.query.filter_by(username=get_jwt_identity()).first_or_404()
    reviews = Review.query.filter_by(user_id=user.id).all()
    return render_template('reviews.html', reviews=reviews)

@auth_app.route('/reviews/<int:review_id>/update', methods=['POST'])
@jwt_required()
def update_review(review_id):
    """Handle AJAX request to update review text and/or rating"""
    user = User.query.filter_by(username=get_jwt_identity()).first_or_404()
    review = Review.query.filter_by(id=review_id, user_id=user.id).first_or_404()
    data = request.get_json() or {}
    text = data.get('text')
    rating = data.get('rating')
    if text is not None:
        review.text = text
    if rating is not None:
        review.rating = rating
    db.session.commit()
    return jsonify({
        'id': review.id,
        'text': review.text,
        'rating': review.rating,
        'date_posted': review.date_posted.isoformat()
    })

@auth_app.route('/search', methods=['GET'])
def search_page():
    """Render and handle the book search page"""
    query = request.args.get('q', '')
    results = []
    if query:
        results = Book.query.filter(Book.title.ilike(f'%{query}%')).all()
    return render_template('search.html', results=results)
