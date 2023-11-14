# Imports - Externals
from flask import jsonify, request
from flask.views import MethodView

# Imports - Local
from ticket_status_model import TicketStatuses

class TicketStatusView(MethodView):
    def __init__(self):
        self.ticket_status_model = TicketStatuses()

    def get(self, id):
        if id is None:
             return jsonify(self.ticket_status_model.list())
        else:
            ticket = self.ticket_status_model.find(id)
            if ticket is not None:
                return jsonify(ticket), 200
            else:
                return jsonify({"error": "Ticket Status Not Found"}), 404
