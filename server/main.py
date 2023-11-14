#!/usr/bin/env python3

# Imports
import socket
from tinydb import TinyDB, Query
from flask import Flask, jsonify, request
import uuid
from datetime import datetime, timezone

# Imports - Local
from ticket_view import TicketView
from ticket_status_view import TicketStatusView
from user_view import UserView
from user_status_view import UserStatusView
from problem_type_view import ProblemTypeView


hostname = socket.gethostname()
IPAddr = socket.gethostbyname(hostname)
 

# Setup App
app      = Flask(__name__)
hostname = socket.gethostname() # Used for IP Address Setting
IPAddr   = socket.gethostbyname(hostname) # Used for IP Address Setting


# Connect to Database
db = TinyDB('database/db.json')
cars_table = db.table('cars')
Car = Query()


# Register Tickets (View)
ticket_view = TicketView.as_view('TicketView')
app.add_url_rule('/tickets',             view_func=ticket_view, methods=['GET', 'POST'], defaults={'id': None})
app.add_url_rule('/tickets/<string:id>', view_func=ticket_view, methods=['GET', 'PUT'])

# Register Ticket Status (View)
ticket_status_view = TicketStatusView.as_view('TicketStatusView')
app.add_url_rule('/ticketStatuses',             view_func=ticket_status_view, methods=['GET'], defaults={'id': None})
app.add_url_rule('/ticketStatuses/<string:id>', view_func=ticket_status_view, methods=['GET'])

# Register Users (View)
user_view = UserView.as_view('UserView')
app.add_url_rule('/users',             view_func=user_view, methods=['GET'], defaults={'id': None})
app.add_url_rule('/users/<string:id>', view_func=user_view, methods=['GET'])
app.add_url_rule('/users/auth',        view_func=user_view, methods=['POST'])

# Register User Status (View)
user_status_view = UserStatusView.as_view('UserStatusView')
app.add_url_rule('/userStatuses',             view_func=user_status_view, methods=['GET'], defaults={'id': None})
app.add_url_rule('/userStatuses/<string:id>', view_func=user_status_view, methods=['GET'])

# Register Problem Types (View)
problem_type_view = ProblemTypeView.as_view('ProblemTypeView')
app.add_url_rule('/problemTypes',             view_func=problem_type_view, methods=['GET'], defaults={'id': None})
app.add_url_rule('/problemTypes/<string:id>', view_func=problem_type_view, methods=['GET'])

# Start APP
if __name__ == '__main__':
    app.run(host=IPAddr, port=5000, debug=True)
