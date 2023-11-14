# Imports - Externals
from flask import jsonify, request
from flask.views import MethodView

# Imports - Local
from user_model import Users

class UserView(MethodView):
    def __init__(self):
        self.user_model = Users()

    def get(self, id):
        if id is None:
             return jsonify(self.user_model.list())
        else:
            user = self.user_model.find(id)
            if user is not None:
                return jsonify(user)
            else:
                return jsonify({"error": "user Not Found"}), 404
    
    def put(self, id):
        print(id)
        return self.get(id)
