# Imports - Externals
from flask import jsonify, request
from flask.views import MethodView

# Imports - Local
from problem_type_model import ProblemTypes

class ProblemTypeView(MethodView):
    def __init__(self):
        self.problem_type_model = ProblemTypes()

    def get(self, id):
        if id is None:
             return jsonify(self.problem_type_model.list())
        else:
            ticket = self.problem_type_model.find(id)
            if ticket is not None:
                return jsonify(ticket), 200
            else:
                return jsonify({"error": "Problem Type Not Found"}), 404
