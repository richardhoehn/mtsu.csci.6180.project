# Imports
import json
from tinydb import TinyDB, Query
import uuid
from datetime import datetime, timezone

# Setup Defaults
default_file = 'database/defaults.json'

with open(default_file, 'r') as file:
    default_data = json.load(file)

class Users:
    _instance = None

    # Make Sure we are a Singleton
    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(Users, cls).__new__(cls, *args, **kwargs)
        return cls._instance

    # Constructor
    def __init__(self):
        print(default_data)
        self.userTable = TinyDB('database/db.json').table('users')
        # Setup Defaults
        for user in default_data['users']:
            self.userTable.upsert(user, Query().id == user['id'])
    
    def list(self):
        return self.userTable.all()
    
    def find(self, id):
        return self.userTable.get(Query().id == id)