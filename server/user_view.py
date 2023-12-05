# Imports - Externals
from flask import jsonify, request
from flask.views import MethodView

# Imports - Local
from user_model import Users
from user_status_model import UserStatuses

class UserView(MethodView):
    def __init__(self):
        self.user_model = Users()

    def get(self, id):
        if id is None:
             return jsonify(self.user_model.list())
        else:
            user = self.user_model.find(id)
            if user is not None:
                user['userStatus'] =  UserStatuses().find(user['userStatusId'])
                # Cleanup - Non Need JSON Objects
                user.pop('userStatusId', None)
                return jsonify(user)
            else:
                return jsonify({"error": "user Not Found"}), 404
    
    def post(self):
        data = request.get_json() # This is the Payload details from the APP
        email = data['email']
        password = data['password']
        print(f"\n**** Auth ***\nEmail:\t{email}\nPwd:\t{password}\n*** Auth ***\n")
        user = self.user_model.auth(email, password)
        if user is not None:
            return self.get(user['id'])
        else:
            return jsonify({"error": "user Not Found"}), 401
        
