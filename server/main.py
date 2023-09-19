#!/usr/bin/env python3

# Imports
from tinydb import TinyDB, Query


# Connect to Database
db = TinyDB('database/db.json')

cars = db.table('cars')

cars.insert({'id':1, 'name':'Richard', 'licensePlate':'123ABC'})

print(cars.all())
