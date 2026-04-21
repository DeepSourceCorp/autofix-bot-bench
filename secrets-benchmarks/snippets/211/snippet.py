import os
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import create_access_token, jwt_required, JWTManager
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

app = Flask(__name__)

# Configuration block with hardcoded credentials
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres://user_svc_acct:p9#zF!8k@L$sR_Wv@db-users.internal.corp:5432/users'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = 'u$h3Jk!^nL*8g$Pz@qV5sR9b#Gf2M(wE' 
SENDGRID_API_KEY = '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'

db = SQLAlchemy(app)
jwt = JWTManager(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)

@app.route('/login', methods=['POST'])
def login():
    username = request.json.get('username', None)
    password = request.json.get('password', None)
    # Dummy auth check
    if username != 'test' or password != 'test':
        return jsonify({'msg': 'Bad username or password'}), 401

    access_token = create_access_token(identity=username)
    return jsonify(access_token=access_token)

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
