from flask import Flask, request, jsonify

app = Flask(__name__)

# Sample book data
database = [
    {"title": "Dune", "genre": "Science Fiction", "date": "1965"},
    {"title": "The Shining", "genre": "Horror", "date": "1977"},
    {"title": "1984", "genre": "Dystopian", "date": "1949"},
    {"title": "Pride and Prejudice", "genre": "Romance", "date": "1813"},
    {"title": "Sapiens", "genre": "Science & Technology", "date": "2011"}
]

@app.route("/search", methods=["GET"])
def search_books():
    query = request.args.get("query", "").lower()
    filter_type = request.args.get("filter", "all")
    
    if not query:
        return jsonify({"error": "Search query is required"}), 400

    results = []
    for book in database:
        if filter_type == "all" or filter_type == "title":
            if query in book["title"].lower():
                results.append(book)
                continue
        if filter_type == "genre" and query in book["genre"].lower():
            results.append(book)
            continue
        if filter_type == "date" and query in book["date"]:
            results.append(book)

    return jsonify(results)

if __name__ == "__main__":
    app.run(debug=True)
