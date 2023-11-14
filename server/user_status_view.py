# Imports - Externals
from flask import jsonify, request
from flask.views import MethodView

# Imports - Local
from user_status_model import UserStatuses

class UserStatusView(MethodView):
    def __init__(self):
        self.user_status_model = UserStatuses()

    def get(self, id):
        if id is None:
             return jsonify(self.user_status_model.list())
        else:
            user = self.user_status_model.find(id)
            if user is not None:
                return jsonify(user), 200
            else:
                return jsonify({"error": "User Status Not Found"}), 404
