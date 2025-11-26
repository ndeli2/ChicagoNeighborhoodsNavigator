from flask import Flask, render_template, request, jsonify
from db import get_connection

app = Flask(__name__)

# Page route
@app.route("/")
def index():
    return render_template("index.html")


# API: get neighborhoods (with filters)
@app.route("/api/neighborhoods")
def api_neighborhoods():
    crime = request.args.get("crime")      # 'low' / 'medium' / 'high' or None
    afford = request.args.get("afford")    # 'affordable' / 'moderate' / 'expensive' or None
    region = request.args.get("region")    # region string or None

    conn = get_connection()
    try:
        with conn.cursor() as cur:
            sql = """
                SELECT
                    n.name,
                    n.description,
                    n.population,
                    n.median_income,
                    n.region,
                    c.crime_score,
                    c.annual_incidents,
                    a.median_rent,
                    a.median_home_value,
                    a.affordability_category
                FROM Neighborhoods n
                JOIN CrimeStats c ON n.neighborhood_id = c.neighborhood_id
                JOIN Affordability a ON n.neighborhood_id = a.neighborhood_id
                WHERE 1 = 1
            """
            params = []

            # Apply filters if provided
            if crime:
                sql += " AND LOWER(c.crime_score) = %s"
                params.append(crime.lower())

            if afford:
                sql += " AND LOWER(a.affordability_category) = %s"
                params.append(afford.lower())

            if region:
                sql += " AND n.region = %s"
                params.append(region)

            cur.execute(sql, params)
            rows = cur.fetchall()

        # Convert DB rows into the shape front-end expects
        result = []
        for r in rows:
            result.append({
                "name": r["name"],
                "description": r["description"],
                "population": r["population"],
                "median_income": r["median_income"],
                "region": r["region"],
                "crime": {
                    "level": r["crime_score"].lower(),          # 'Low' -> 'low'
                    "incidents": r["annual_incidents"]
                },
                "affordability": {
                    "median_rent": r["median_rent"],
                    "median_home": r["median_home_value"],
                    "category": r["affordability_category"].lower()
                }
            })

        return jsonify(result)
    finally:
        conn.close()

@app.route("/api/signup", methods=["POST"])
def api_signup():
    data = request.json
    name = data.get("name")
    email = data.get("email")
    password = data.get("password")

    if not (name and email and password):
        return jsonify({"error": "Missing fields"}), 400

    conn = get_connection()
    try:
        with conn.cursor() as cur:
            # Check if user exists
            cur.execute("SELECT * FROM Users WHERE email=%s", (email,))
            if cur.fetchone():
                return jsonify({"error": "Email already exists"}), 400

            # Insert user
            cur.execute(
                "INSERT INTO Users (name, email, password) VALUES (%s, %s, %s)",
                (name, email, password)
            )
            conn.commit()
            user_id = cur.lastrowid

        return jsonify({"user_id": user_id, "name": name, "email": email})
    finally:
        conn.close()

@app.route("/api/login", methods=["POST"])
def api_login():
    data = request.json
    email = data.get("email")
    password = data.get("password")

    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute(
                "SELECT user_id, name, email FROM Users WHERE email=%s AND password=%s",
                (email, password)
            )
            row = cur.fetchone()
            if not row:
                return jsonify({"error": "Invalid credentials"}), 401

        return jsonify(row)
    finally:
        conn.close()

@app.route("/api/favorite", methods=["POST"])
def api_add_favorite():
    data = request.json
    user_id = data.get("user_id")
    neighborhood = data.get("name")

    if not (user_id and neighborhood):
        return jsonify({"error": "Missing fields"}), 400

    conn = get_connection()
    try:
        with conn.cursor() as cur:
            # Get neighborhood_id from name
            cur.execute("SELECT neighborhood_id FROM Neighborhoods WHERE name=%s", (neighborhood,))
            row = cur.fetchone()
            if not row:
                return jsonify({"error": "Neighborhood not found"}), 404
            nid = row["neighborhood_id"]

            cur.execute(
                "INSERT INTO Favorites (user_id, neighborhood_id) VALUES (%s, %s)",
                (user_id, nid)
            )
            conn.commit()

        return jsonify({"success": True})
    finally:
        conn.close()

@app.route("/api/unfavorite", methods=["POST"])
def api_unfavorite():
    data = request.json
    user_id = data.get("user_id")
    neighborhood = data.get("name")

    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT neighborhood_id FROM Neighborhoods WHERE name=%s", (neighborhood,))
            row = cur.fetchone()
            if not row:
                return jsonify({"error": "Neighborhood not found"}), 404
            nid = row["neighborhood_id"]

            cur.execute(
                "DELETE FROM Favorites WHERE user_id=%s AND neighborhood_id=%s",
                (user_id, nid)
            )
            conn.commit()

        return jsonify({"success": True})
    finally:
        conn.close()

@app.route("/api/favorites")
def api_favorites():
    user_id = request.args.get("user_id")

    conn = get_connection()
    try:
        with conn.cursor() as cur:
            sql = """
                SELECT n.name
                FROM Favorites f
                JOIN Neighborhoods n ON f.neighborhood_id = n.neighborhood_id
                WHERE f.user_id = %s
            """
            cur.execute(sql, (user_id,))
            rows = cur.fetchall()

        return jsonify([r["name"] for r in rows])
    finally:
        conn.close()

if __name__ == "__main__":
    app.run(debug=True)
