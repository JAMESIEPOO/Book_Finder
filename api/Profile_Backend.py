from flask import Blueprint, render_template, session
import psycopg2
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Create Blueprint
profile_api = Blueprint('profile_api', __name__, url_prefix='/profile')

def connect_db():
    return psycopg2.connect(
        dbname=os.getenv('DB_NAME'),
        user=os.getenv('USER_DB', 'postgres'),
        password=os.getenv('PASSWORD_DB', 'password'),
        host='localhost',
        port='5432'
    )

@profile_api.route('/', methods=['GET'])
def profile_page():
    username = session.get('username', 'User')  # fallback if session empty
    return render_template('usr_profile.html', username=username)
