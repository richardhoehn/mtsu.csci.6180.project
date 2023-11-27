# Imports - Externals
from flask import jsonify, request
from flask.views import MethodView

# Imports - Local
from ticket_model import Tickets
from ticket_status_model import TicketStatuses
from problem_type_model import ProblemTypes
from user_model import Users

class TicketView(MethodView):
    def __init__(self):
        self.ticket_model = Tickets()

    def get(self, id):
        if id is None:
             return jsonify(self.ticket_model.list())
        else:
            ticket = self.ticket_model.find(id)
            if ticket is not None:
                ticket['ticketStatus'] =  TicketStatuses().find(ticket['ticketStatusId'])
                ticket['problemType'] = ProblemTypes().find(ticket['problemTypeId'])
                ticket['create'] = {'at': ticket['createAt'], 'by': Users().find(ticket['createBy'])}
                ticket['update'] = {'at': ticket['updateAt'], 'by': Users().find(ticket['updateBy'])}

                # Cleanup - Non Need JSON Objects
                ticket.pop('ticketStatusId', None)
                ticket.pop('problemTypeId', None)
                ticket.pop('createAt', None)
                ticket.pop('createBy', None)
                ticket.pop('updateAt', None)
                ticket.pop('updateBy', None)
                return jsonify(ticket), 200
            else:
                return jsonify({"error": "Ticket Not Found"}), 404
    
    def put(self, id):
        data = request.args
        #TODO: Need To handle the geoLocation object somehow...
        self.ticket_model.update(id, data)
        return self.get(id)


    def post(self):
        data = request.get_json() # This is the Payload details from the APP
        ticket = self.ticket_model.add(data)
        return self.get(ticket['id'])
