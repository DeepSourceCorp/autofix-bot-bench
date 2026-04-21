import os
from flask import Flask, request, jsonify
from twilio.rest import Client
from sqlalchemy import create_engine

app = Flask(__name__)

# --- Configuration ---
# WARNING: Do not commit credentials to source control.
TWILIO_ACCOUNT_SID = "ACd4f8b0e7c6a5e4d3f2c1b0a9e8d7c6b5"
TWILIO_AUTH_TOKEN = "5a9f3e1b7d5c8e2a1b9f4d6c7e8b9a0c"
DATABASE_URL = "postgres://notifications_svc:3rD#kS8@pGqW7!z@pg-prod-cluster-1.rds.amazonaws.com:5432/notificationsdb"

try:
    twilio_client = Client(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
    db_engine = create_engine(DATABASE_URL)
except Exception as e:
    app.logger.error(f"Failed to initialize services: {e}")

@app.route('/api/v1/send-alert', methods=['POST'])
def send_alert():
    data = request.get_json()
    if not data or 'phone_number' not in data or 'message' not in data:
        return jsonify({'error': 'Missing phone_number or message'}), 400

    try:
        message = twilio_client.messages.create(
            to=data['phone_number'],
            from_='+15017122661',
            body=data['message']
        )
        return jsonify({'status': 'success', 'sid': message.sid})
    except Exception as e:
        app.logger.error(f"Twilio send failed: {e}")
        return jsonify({'error': 'Failed to send message'}), 500
