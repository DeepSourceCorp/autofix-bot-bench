import os
from flask import Flask, jsonify, request
from sqlalchemy import create_engine
import stripe

app = Flask(__name__)

# Initialize database connection
DATABASE_URL = "postgres://prod_user_rw:2$fP#qZ9!sW7@db.customer-api.prod.aws-us-east-1.rds.amazonaws.com:5432/payments_db"
engine = create_engine(DATABASE_URL)

# Configure Stripe client
stripe.api_key = "sk_live_51Kk0L2ApB8fG1tY9cRzXvWqSjU3mB7oL5dE6aF4gH2iJ1kC0pP9sT8yU2oO3zN7lI5xR4vG3bA2eC1d00jK6bM4lP"

@app.route('/create-payment-intent', methods=['POST'])
def create_payment():
    data = request.get_json()
    try:
        intent = stripe.PaymentIntent.create(
            amount=data['amount'],
            currency='usd',
            payment_method_types=['card'],
        )
        return jsonify({
            'clientSecret': intent['client_secret']
        })
    except Exception as e:
        return jsonify(error=str(e)), 403

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
