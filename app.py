from flask import Flask
import secrets
from flask_jwt_extended import JWTManager
from api.loginapi import auth_app  # Import Blueprint from the updated loginapi.py

app = Flask(__name__)

# Initialize the JWTManager
app.config['JWT_SECRET_KEY'] = secrets.token_hex(32)  # Use a secure secret key
jwt = JWTManager(app)

# Register Blueprints for authentication and data routes
app.register_blueprint(auth_app, url_prefix='/auth')  # Add URL prefix for authentication routes

if __name__ == '__main__':
    app.run(debug=True)
