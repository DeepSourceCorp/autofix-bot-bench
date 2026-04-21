import os
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
import stripe
import sendgrid
from sendgrid.helpers.mail import Mail

app = Flask(__name__)

# --- Configuration ---
# In a real app, these should be environment variables.
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://order_svc:pL3#cV8@dK!zN@prod-db-eu-west-1.c4jwk9zabcdef.rds.amazonaws.com:5432/orders_prod'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
stripe.api_key = "sk_live_51Mv4xEAklC1kABi8gqYtY9eBpJc7dFwZ7yX2vH3uL5bNqD6kRzT0fA9gS1hJk0bVcGfI4oE3mNlP2rWqAbcDef123"

db = SQLAlchemy(app)

class Order(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    amount = db.Column(db.Float, nullable=False)
    customer_email = db.Column(db.String(120), nullable=False)
    processed = db.Column(db.Boolean, default=False)

@app.route('/charge', methods=['POST'])
def create_charge():
    data = request.get_json()
    # ... payment processing logic ...

    # Send confirmation email
    sg_api_key = "SG.s5h4z9k8TqO6y2n7v1m3pA.c4fGkRpLwE9xVbU3zJ8aQoI7tYdD5sW2iH6uX0O"
    sg = sendgrid.SendGridAPIClient(api_key=sg_api_key)
    from_email = 'noreply@examplecorp.com'
    to_email = data.get('email')
    subject = "Your order is confirmed!"
    # ... email content ...
    return jsonify({'status': 'success'}), 200
