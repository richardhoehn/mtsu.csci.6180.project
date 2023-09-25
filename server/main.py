#!/usr/bin/env python3

# Imports
from tinydb import TinyDB, Query
from flask import Flask, jsonify, request
import uuid
from datetime import datetime, timezone


# Setup App
app = Flask(__name__)


# Connect to Database
db = TinyDB('database/db.json')
cars_table = db.table('cars')
Car = Query()

# Route to get ALL cars
@app.route('/cars', methods=['GET'])
def get_cars():
    return jsonify(cars_table.all())


# Route for GET of a Single Car by ID
@app.route('/cars/<string:car_id>', methods=['GET'])
def get_car_by_id(car_id):
    car = cars_table.get(Car.id == car_id)
    if car is not None:
        return jsonify(car)
    else:
        return jsonify({"error": "Car not found"}), 404

# Route for adding a new car (POST request)
@app.route('/cars', methods=['POST'])
def add_car():
    data = request.get_json() # This is the Payload details from the APP
    id = str(uuid.uuid4()) # Generate a unique UUID for the new car
    create_at = datetime.now(timezone.utc).isoformat()

    print(data)

    # This is just test code - WE will pulls this from the "payload" POST event
    new_car = {
        'id': id,
        'licencePlate': data['licencePlate'],
        'name': data['name'],
        'lat': data['lat'],
        'lng': data['lng'],
        'status': 0,
        'createAt': create_at
    }

    print(new_car)

    cars_table.insert(new_car)
    # Return the "Saved" car by calling the method that return if we use GET
    return get_car_by_id(id), 200   # This is good practice so we know what has been saved.


# Start APP
if __name__ == '__main__':
    app.run(debug=True)