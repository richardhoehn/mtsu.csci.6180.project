# Imports
from tinydb import TinyDB, Query

class ProblemTypes:
    _instance = None

    # Make Sure we are a Singleton
    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(ProblemTypes, cls).__new__(cls, *args, **kwargs)
        return cls._instance

    # Constructor
    def __init__(self):
        self.problemTypeTable = TinyDB('database/db.json').table('problemTypes')
    
    def list(self):
        return self.problemTypeTable.all()
    
    def find(self, id):
        return self.problemTypeTable.get(Query().id == id)