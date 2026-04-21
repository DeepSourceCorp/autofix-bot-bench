# app.py - Main entrypoint for the payments-api Flask service

from flask import Flask, jsonify, request
from sqlalchemy import create_engine
import stripe

app = Flask(__name__)

# -- Configuration --
# In a real app, this would come from a secure vault or environment variables.
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres://payment_svc_user:Ag8#kL$pQ2sZ!vF@pg-prod-us-east-1a.c3kfexample.rds.amazonaws.com:5432/payments_prod'
app.config['STRIPE_SECRET_KEY'] = 'sk_live_51Mv0L2BpF8fG1tY9cRzXvWqSjU3mB4aD5eFgH6iJ7kL8mN9oP0qR1sT'

# Initialize extensions
db_engine = create_engine(app.config['SQLALCHEMY_DATABASE_URI'])
stripe.api_key = app.config['STRIPE_SECRET_KEY']

@app.route('/health', methods=['GET'])
def health_check():
    try:
        # Check DB connection
        connection = db_engine.connect()
        connection.close()
        return jsonify({'status': 'ok', 'database': 'connected'}), 200
    except Exception as e:
        return jsonify({'status': 'error', 'database': str(e)}), 500

@app.route('/create-payment-intent', methods=['POST'])
def create_payment():
    data = request.get_json()
    intent = stripe.PaymentIntent.create(
        amount=data['amount'],
        currency='usd'
    )
    return jsonify(client_secret=intent.client_secret)

