from flask import Flask, jsonify, request

app = Flask(__name__)

# Mock database for books
books = {
    "1234567890": {
        "title": "Sample Book",
        "author": "John Doe",
        "genre": "Fiction",
        "published": "2024",
        "isbn": "1234567890",
        "pages": 123,
        "language": "English",
        "publisher": "Publisher Name",
        "description": "This is a sample book description.",
        "cover_image": "/api/placeholder/300/450"
    }
}

# Mock wishlist
wishlist = set()

@app.route("/api/book/<isbn>", methods=["GET"])
def get_book(isbn):
    book = books.get(isbn)
    if book:
        return jsonify(book)
    return jsonify({"error": "Book not found"}), 404

@app.route("/api/wishlist", methods=["POST"])
def add_to_wishlist():
    data = request.json
    isbn = data.get("isbn")
    if isbn in books:
        wishlist.add(isbn)
        return jsonify({"message": "Book added to wishlist", "wishlist": list(wishlist)})
    return jsonify({"error": "Book not found"}), 404

@app.route("/api/wishlist/<isbn>", methods=["DELETE"])
def remove_from_wishlist(isbn):
    if isbn in wishlist:
        wishlist.remove(isbn)
        return jsonify({"message": "Book removed from wishlist", "wishlist": list(wishlist)})
    return jsonify({"error": "Book not in wishlist"}), 404

if __name__ == "__main__":
    app.run(debug=True)
