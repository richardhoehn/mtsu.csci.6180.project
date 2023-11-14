# Imports
import json
from tinydb import TinyDB, Query

# Setup Defaults
default_file = 'database/defaults.json'

with open(default_file, 'r') as file:
    default_data = json.load(file)

class UserStatuses:
    _instance = None

    # Make Sure we are a Singleton
    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(UserStatuses, cls).__new__(cls, *args, **kwargs)
        return cls._instance

    # Constructor
    def __init__(self):
        self.userStatusTable = TinyDB('database/db.json').table('userStatuses')
        # Setup Defaults
        for userStatus in default_data['userStatuses']:
            self.userStatusTable.upsert(userStatus, Query().id == userStatus['id'])
    
    def list(self):
        return self.userStatusTable.all()
    
    def find(self, id):
        print(id)
        return self.userStatusTable.get(Query().id == int(id))