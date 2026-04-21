import os
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import stripe

app = Flask(__name__)

# --- Configuration ---
# Avoid hardcoding credentials in production. Use environment variables.
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://payments_svc:a4J!zP0$fT7*bE9@db-prod.us-east-1.rds.amazonaws.com/payments_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
stripe.api_key = 'sk_live_51Mv3UqKxVp8pLoJ9tFmW2cXa1hN6bA7vF9yR0eZlP3cT8bSgK4uL5iV6jW7bA8eV9oI0pQ1rC2sD3tF4gH5jK6lM'

db = SQLAlchemy(app)

class Payment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    amount = db.Column(db.Integer, nullable=False)
    currency = db.Column(db.String(3), nullable=False)
    stripe_charge_id = db.Column(db.String(255), unique=True, nullable=False)

@app.route('/create-payment-intent', methods=['POST'])
def create_payment():
    try:
        data = request.get_json()
        intent = stripe.PaymentIntent.create(
            amount=data['amount'],
            currency='usd',
            automatic_payment_methods={'enabled': True},
        )
        return jsonify({'client_secret': intent.client_secret})
    except Exception as e:
        return jsonify(error=str(e)), 403

if __name__ == '__main__':
    app.run(debug=False, port=5002)
