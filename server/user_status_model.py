# Imports
from tinydb import TinyDB, Query

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
        self.userStatusTable.upsert({'id': 1, 'name': 'Active'},     Query().id == 1)
        self.userStatusTable.upsert({'id': 2, 'name': 'Admin'},      Query().id == 2)
        self.userStatusTable.upsert({'id': 3, 'name': 'Non-Active'}, Query().id == 3)
    
    def list(self):
        return self.userStatusTable.all()
    
    def find(self, id):
        print(id)
        return self.userStatusTable.get(Query().id == int(id))