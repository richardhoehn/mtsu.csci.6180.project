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
    
    def list(self):
        return self.ticketStatusTable.all()
    
    def find(self, id):
        return self.ticketStatusTable.get(Query().id == id)