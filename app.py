from flask import Flask
import secrets 
import os
from flask_jwt_extended import JWTManager 
from datetime import timedelta 
from api.loginapi import auth_app
from api.Backend_Search import search_api
from api.Backend_Book_Details import book_detail_api
from api.Profile_Backend import profile_api
from api.Backend_FavoritesPage import favorites_api
from api.Backend_Reviews import reviews_api

app = Flask(__name__, template_folder='../templates', static_folder='static')

# Register the blueprint only once
app.register_blueprint(auth_app, url_prefix='/')
app.register_blueprint(search_api)
app.register_blueprint(book_detail_api)
app.register_blueprint(profile_api)
app.register_blueprint(favorites_api)
app.register_blueprint(reviews_api)

# Configuration
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(minutes=60)
app.config['JWT_REFRESH_TOKEN_EXPIRES'] = timedelta(days=7)
app.config['JWT_SECRET_KEY'] = secrets.token_hex(32)
app.secret_key = os.getenv('SECRET_KEY', 'dev_secret')  # Required for sessions

# Initialize JWT manager
jwt = JWTManager(app)

if __name__ == '__main__':
    app.run(debug=True)
