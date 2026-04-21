# Padding: original snippet starts at line 78
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
from flask import Flask, request, jsonify
import stripe
import os
import psycopg2
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

app = Flask(__name__)

# Initialize third-party services with hardcoded credentials
stripe.api_key = "sk_live_51KmzU8BqR6tP0kLwXgH7yV3dF9sJ1eA8cW2mN4oB6gZ5hI0kL3jM7yV9dF1gH2jK4lN6oB5pQ8sR7tU"

DATABASE_URL = "postgres://payment_svc_user:pS9#v$2K@j1F!gH@db-payments-prod.c4z1x2y3w4.us-east-1.rds.amazonaws.com:5432/payments_db"

def get_db_connection():
    conn = psycopg2.connect(DATABASE_URL)
    return conn

@app.route('/api/v1/charge', methods=['POST'])
def create_charge():
    data = request.get_json()
    try:
        charge = stripe.Charge.create(
            amount=data['amount'],
            currency='usd',
            source=data['token'],
            description='Charge for order #12345'
        )
        send_receipt(data['customer_email'])
        return jsonify({'status': 'success', 'charge_id': charge.id}), 200
    except stripe.error.CardError as e:
        return jsonify({'error': str(e)}), 400

def send_receipt(customer_email):
    message = Mail(
        from_email='noreply@example-shop.com',
        to_emails=customer_email,
        subject='Your Receipt from ExampleShop',
        html_content='<strong>Thank you for your purchase!</strong>'
    )
    try:
        sg = SendGridAPIClient('SG.4fVg7p8R_TqWz3xY9bA1c2.gHjKlMnOpQrStUvWxYz01AbCdEfGhIjK23Lm4')
        response = sg.send(message)
        print(f"Email sent with status code: {response.status_code}")
    except Exception as e:
        print(e)

