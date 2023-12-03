# Imports
from tinydb import TinyDB, Query
import uuid
from datetime import datetime, timezone
import json


class Tickets:
    _instance = None
    # Make Sure we are a Singleton
    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(Tickets, cls).__new__(cls, *args, **kwargs)
        return cls._instance

    # Constructor
    def __init__(self):
        self.ticketTable = TinyDB('database/db.json').table('tickets')
        self.ticketQuery = Query()
    
    def list(self):
        return self.ticketTable.all()
    
    def find(self, id):
        return self.ticketTable.get(Query().id == id)
    
    def add(self, data):
        id = str(uuid.uuid4()) # Generate a unique UUID for the new car
        create_at = datetime.now(timezone.utc).isoformat()
        zero_uuid = str(uuid.UUID(int=0))
        geoLocation = data['geoLocation']

        ticket = {
            'id': id,
            'licencePlate': data['licencePlate'],
            'name': data['name'],
            'geoLocation': {
                'lat': geoLocation['lat'],
                'lng': geoLocation['lng'],
            },
            'ticketStatusId': 1,
            'problemTypeId': 1,
            'createAt': create_at,
            'createBy': zero_uuid,
            'updateAt': create_at,
            'updateBy': zero_uuid
        }

        # Add the "ticket" to the Database
        self.ticketTable.insert(ticket)
        return ticket
    
    def update(self, id, data):
        return self.ticketTable.update(data, Query().id == id)