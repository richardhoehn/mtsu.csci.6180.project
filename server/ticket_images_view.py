# Imports - Externals
from flask import jsonify, request, redirect, url_for
from flask.views import MethodView

# Imports - Local

class TicketImagesView(MethodView):

    def get(self, id): 
        img = f"{id}.png"
        url = url_for('images', filename=img)
        redirect(url, code=302)
        return {"imageUrl": url}     

    def post(self, id):
        return {"url": "1234.png"} 
