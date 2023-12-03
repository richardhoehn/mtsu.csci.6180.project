# Imports - Externals
from flask import jsonify, request
from flask.views import MethodView

# Imports - Local
from ticket_model import Tickets
from ticket_status_model import TicketStatuses
from problem_type_model import ProblemTypes
from user_model import Users
from user_status_model import UserStatuses

class TicketView(MethodView):
    def __init__(self):
        self.ticket_model = Tickets()

    def get(self, id):
        if id is None:
            dbObjects = self.ticket_model.list()
            ticketObjects = []

            for dbObject in dbObjects:
                ticketObjects.append(self.__parseTicket(dbObject))

            return jsonify(ticketObjects), 200
        else:
            dbTicketObject = self.ticket_model.find(id)
            if dbTicketObject is not None:
                return jsonify(self.__parseTicket(dbTicketObject)), 200
            else:
                return jsonify({"error": "Ticket Not Found"}), 404
    
    def put(self, id):
        data = request.json
        self.ticket_model.update(id, data)
        return self.get(id)


    def post(self):
        data = request.json # This is the Payload details from the APP
        ticket = self.ticket_model.add(data)
        return self.get(ticket['id'])
    
    def __parseTicket(self, dbTicketObject):
        print(dbTicketObject)
        dbTicketObject['ticketStatus'] =  TicketStatuses().find(dbTicketObject['ticketStatusId'])
        dbTicketObject['problemType'] = ProblemTypes().find(dbTicketObject['problemTypeId'])
        dbTicketObject['create'] = {'at': dbTicketObject['createAt'], 'by': Users().find(dbTicketObject['createBy'])}
        dbTicketObject['update'] = {'at': dbTicketObject['updateAt'], 'by': Users().find(dbTicketObject['updateBy'])}
        
        # Hanlde Nested Status
        dbTicketObject['create']['by']['userStatus'] =  UserStatuses().find(dbTicketObject['create']['by']['userStatusId'])
        dbTicketObject['update']['by']['userStatus'] =  UserStatuses().find(dbTicketObject['update']['by']['userStatusId'])

        # Cleanup - Non Need JSON Objects
        dbTicketObject.pop('ticketStatusId', None)
        dbTicketObject.pop('problemTypeId', None)
        dbTicketObject.pop('createAt', None)
        dbTicketObject.pop('createBy', None)
        dbTicketObject.pop('updateAt', None)
        dbTicketObject.pop('updateBy', None)
        return dbTicketObject
