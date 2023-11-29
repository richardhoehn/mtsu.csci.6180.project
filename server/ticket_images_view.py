# Imports - Externals
import os
from flask import flash, request, redirect, url_for
from flask.views import MethodView

# Imports - Local

class TicketImagesView(MethodView):

    def get(self, id): 
        img = f"{id}.jpg"
        url = url_for('images', filename=img)
        redirect(url, code=302)
        return {"imageUrl": url}     

    def post(self, id):
        file = request.files['file']
        fileName = f"{id}.{file.filename.split('.')[1]}"
        filePath = os.path.join('./images/', fileName)
        file.save(filePath)
        return {'success':True} 
