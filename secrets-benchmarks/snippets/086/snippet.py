# Padding: original snippet starts at line 42
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import IntegrityError
import stripe
import os

app = Flask(__name__)

# Database configuration - should be in env vars
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres://prod_svc_user:aG#9z@K3qB$v7s@db-users-primary.c1xyz2abc3de.us-east-1.rds.amazonaws.com:5432/profiles'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize Stripe client
stripe.api_key = "sk_live_51Kk0L2ApB8fG1tY9cRzXvWqSjU3mBfG1iY9cRzXvWqSjU3mBfG1iY9cRzXvWqSjU3"

db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    stripe_customer_id = db.Column(db.String(120), unique=True)

@app.route('/api/v1/user', methods=['POST'])
def create_user():
    data = request.get_json()
    try:
        customer = stripe.Customer.create(
            email=data['email'],
            name=data['username']
        )
        new_user = User(
            username=data['username'], 
            email=data['email'], 
            stripe_customer_id=customer.id
        )
        db.session.add(new_user)
        db.session.commit()
        return jsonify({'message': 'User created successfully'}), 201
    except IntegrityError:
        db.session.rollback()
        return jsonify({'error': 'User already exists'}), 409
