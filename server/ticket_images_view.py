# Imports - Externals
from flask import jsonify, request
from flask.views import MethodView

# Imports - Local

class TicketImagesView(MethodView):

    def get(self, id):
        return {"url": "1234.png"}        

    def post(self, id):
        return {"url": "1234.png"} 
