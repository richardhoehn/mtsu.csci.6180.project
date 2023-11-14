# Imports
import json
from tinydb import TinyDB, Query

# Setup Defaults
default_file = 'database/defaults.json'

with open(default_file, 'r') as file:
    default_data = json.load(file)
class TicketStatuses:
    _instance = None

    # Make Sure we are a Singleton
    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(TicketStatuses, cls).__new__(cls, *args, **kwargs)
        return cls._instance

    # Constructor
    def __init__(self):
        self.ticketStatusTable = TinyDB('database/db.json').table('ticketStatuses')
        # Setup Defaults
        for ticketStatus in default_data['ticketStatuses']:
            self.ticketStatusTable.upsert(ticketStatus, Query().id == ticketStatus['id'])
    
    def list(self):
        return self.ticketStatusTable.all()
    
    def find(self, id):
        return self.ticketStatusTable.get(Query().id == int(id))