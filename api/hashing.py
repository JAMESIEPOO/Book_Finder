import psycopg2
import bcrypt
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()


# Database connection setup
def connect_db():
    return psycopg2.connect(
        dbname= 'Book_FinderV4',
        user= 'postgres',
        password= 'password',
        host='localhost',
        port='5432'
    )


# Function to hash passwords and update them in the database
def hash_passwords():
    # Connect to the database
    conn = connect_db()
    cursor = conn.cursor()

    # Fetch all users with their email and plain text password
    cursor.execute('SELECT "userID", "email", "password" FROM "User"')
    users = cursor.fetchall()

    # For each user, hash their password and update the database
    for user in users:
        user_id, email, plain_password = user
        print(f"Hashing password for user: {email}")

        # Generate a hashed password
        hashed_password = bcrypt.hashpw(plain_password.encode('utf-8'), bcrypt.gensalt())

        # Update the password in the database
        cursor.execute(
            'UPDATE "User" SET "password" = %s WHERE "userID" = %s',
            (hashed_password.decode('utf-8'), user_id)
        )

    # Commit the transaction and close the connection
    conn.commit()
    conn.close()
    print("Password hashing completed and database updated.")


if __name__ == '__main__':
    hash_passwords()
