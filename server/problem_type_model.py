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
        # Setup Defaults
        self.problemTypeTable.upsert({'id': 1, 'name': 'None'},      Query().id == 1)
        self.problemTypeTable.upsert({'id': 2, 'name': 'Lost'},      Query().id == 2)
        self.problemTypeTable.upsert({'id': 3, 'name': 'Stolen'},    Query().id == 3)
        self.problemTypeTable.upsert({'id': 4, 'name': 'Scratched'}, Query().id == 4)

    
    def list(self):
        return self.problemTypeTable.all()
    
    def find(self, id):
        return self.problemTypeTable.get(Query().id == int(id))