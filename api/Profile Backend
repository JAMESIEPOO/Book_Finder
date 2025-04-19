# auth_app_routes.py
from flask import Blueprint, render_template, request
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
    # Assuming Favorite model has a relationship to Book as 'book'
    favorites = [fav.book for fav in user.favorites]
    return render_template('favorites.html', favorites=favorites)

@auth_app.route('/reviews')
@jwt_required()
def usr_reviews():
    """Render the user's book reviews"""
    user = User.query.filter_by(username=get_jwt_identity()).first_or_404()
    reviews = Review.query.filter_by(user_id=user.id).all()
    return render_template('reviews.html', reviews=reviews)

@auth_app.route('/search', methods=['GET'])
def search_page():
    """Render and handle the book search page"""
    query = request.args.get('q', '')
    results = []
    if query:
        results = Book.query.filter(Book.title.ilike(f'%{query}%')).all()
    return render_template('search.html', results=results)

# In your application factory or main file, register the blueprint:
# from auth_app_routes import auth_app
# app.register_blueprint(auth_app)
