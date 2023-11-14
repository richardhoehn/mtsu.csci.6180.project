# Imports
from tinydb import TinyDB, Query

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
        self.ticketStatusTable.upsert({'id': 1, 'name': 'Pending'},    Query().id == 1)
        self.ticketStatusTable.upsert({'id': 2, 'name': 'Parking'},    Query().id == 2)
        self.ticketStatusTable.upsert({'id': 3, 'name': 'Parked'},     Query().id == 3)
        self.ticketStatusTable.upsert({'id': 4, 'name': 'Retrieving'}, Query().id == 4)
        self.ticketStatusTable.upsert({'id': 5, 'name': 'Complete'},   Query().id == 5)
    
    def list(self):
        return self.ticketStatusTable.all()
    
    def find(self, id):
        return self.ticketStatusTable.get(Query().id == int(id))