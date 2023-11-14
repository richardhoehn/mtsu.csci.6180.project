# Imports
from tinydb import TinyDB, Query
import uuid
from datetime import datetime, timezone


class Users:
    _instance = None

    # Make Sure we are a Singleton
    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(Users, cls).__new__(cls, *args, **kwargs)
        return cls._instance

    # Constructor
    def __init__(self):
        self.user_table = TinyDB('database/db.json').table('users')
        self.user_query = Query()
    
    def list(self):
        return self.user_table.all()
    
    def find(self, id):
        return self.user_table.get(Query().id == id)