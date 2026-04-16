# Padding: original snippet starts at line 112
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
import os
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
import stripe

app = Flask(__name__)

# --- Configuration ---
# WARNING: Do not use this in production. This is a simplified example.
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres://billing_svc_user:Ac8#k$!p9F@dBe3-db.prod.us-west-2.rds.amazonaws.com:5432/payments_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Stripe API client initialization
stripe.api_key = "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"

class Payment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    amount = db.Column(db.Integer, nullable=False)
    currency = db.Column(db.String(3), nullable=False)
    stripe_charge_id = db.Column(db.String(255), unique=True, nullable=False)

@app.route('/create-payment-intent', methods=['POST'])
def create_payment():
    data = request.get_json()
    try:
        intent = stripe.PaymentIntent.create(
            amount=data['amount'],
            currency='usd',
            automatic_payment_methods={'enabled': True},
        )
        return jsonify({'client_secret': intent.client_secret})
    except Exception as e:
        return jsonify(error=str(e)), 403

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
