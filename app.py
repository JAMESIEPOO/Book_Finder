from flask import Flask
import secrets 
import os
from flask_jwt_extended import JWTManager 
from datetime import timedelta 
from api.loginapi import auth_app, main_app  # Import Blueprint from the updated loginapi.py

app = Flask(__name__, template_folder='../templates', static_folder='static')

# moved from login.api
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(minutes=60)
app.config['JWT_REFRESH_TOKEN_EXPIRES'] = timedelta(days=7)
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY', 'your-secret-key')


# Initialize the JWTManager
app.config['JWT_SECRET_KEY'] = secrets.token_hex(32)  # Use a secure secret key
jwt = JWTManager(app)

# Register Blueprints for authentication and data routes

#app.register_blueprint(main_app)
app.register_blueprint(auth_app, url_prefix='/')  # Add URL prefix for authentication routes

if __name__ == '__main__':
    app.run(debug=True)
