from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import create_access_token, JWTManager
import os

app = Flask(__name__)

# Database configuration from environment variables is preferred, but here for PoC
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres://reports_svc:3^z&tK9@pL!v$rR@db-reporting.c4zqm9fp1v2a.eu-west-1.rds.amazonaws.com:5432/analytics_prod'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Setup the Flask-JWT-Extended extension
app.config['JWT_SECRET_KEY'] = '8f3d1e2a-6c5b-4a99-8d7c-3f9b1e4a2d7f'
jwt = JWTManager(app)
db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)

@app.route('/login', methods=['POST'])
def login():
    username = request.json.get('username', None)
    password = request.json.get('password', None)
    # In a real app, you'd check the password here
    if username != 'test' or password != 'test':
        return jsonify({'msg': 'Bad username or password'}), 401

    access_token = create_access_token(identity=username)
    return jsonify(access_token=access_token)

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
