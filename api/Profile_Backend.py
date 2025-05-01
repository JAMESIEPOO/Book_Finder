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
        dbname= 'Book_FinderV4',
        user= 'postgres',
        password= 'password',
        host='localhost',
        port='5432'
    )

@profile_api.route('/', methods=['GET'])
def profile_page():
    username = session.get('username', 'User')  # fallback if session empty
    return render_template('usr_profile.html', username=username)
