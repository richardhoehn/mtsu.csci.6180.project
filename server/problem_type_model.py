# Imports
import json
from tinydb import TinyDB, Query

# Setup Defaults
default_file = 'database/defaults.json'

with open(default_file, 'r') as file:
    default_data = json.load(file)

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
        for problemType in default_data['problemTypes']:
            self.problemTypeTable.upsert(problemType, Query().id == problemType['id'])

    
    def list(self):
        return self.problemTypeTable.all()
    
    def find(self, id):
        return self.problemTypeTable.get(Query().id == int(id))