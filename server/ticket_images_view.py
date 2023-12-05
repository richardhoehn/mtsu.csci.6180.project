# Imports - Externals
import os
from flask import request, redirect
from flask.views import MethodView

# Imports - Local

class TicketImagesView(MethodView):

    def get(self, id): 
        imgUrl = f"/images/{id}.jpg"
        return redirect(imgUrl, code=302)

    def post(self, id):
        file = request.files['file']
        fileName = f"{id}.{file.filename.split('.')[1]}"
        filePath = os.path.join('./images/', fileName)
        file.save(filePath)
        return {'success':True} 
