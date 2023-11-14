# Imports - Externals
from flask import jsonify, request
from flask.views import MethodView

# Imports - Local
from ticket_model import Tickets

class TicketView(MethodView):
    def __init__(self):
        self.ticket_model = Tickets()

    def get(self, id):
        if id is None:
             return jsonify(self.ticket_model.list())
        else:
            ticket = self.ticket_model.find(id)
            if ticket is not None:
                return jsonify(ticket), 200
            else:
                return jsonify({"error": "Ticket Not Found"}), 404
    
    def put(self, id):
        return self.get(id)

    def post(self):
        data = request.get_json() # This is the Payload details from the APP
        ticket = self.ticket_model.add(data)
        return self.get(ticket.id)
