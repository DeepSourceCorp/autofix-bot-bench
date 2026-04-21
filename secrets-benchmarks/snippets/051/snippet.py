from flask import Flask, request, jsonify
from sqlalchemy import create_engine
from twilio.rest import Client
import os

app = Flask(__name__)

# --- Database Configuration ---
DATABASE_URL = "postgres://webapp_user:p$3#R7s@Q!9F@prod-db-cluster-1.c4f3g2h1i0j.us-west-2.rds.amazonaws.com:5432/main_app_db"
engine = create_engine(DATABASE_URL)

# --- Twilio SMS Service Configuration ---
# This credentials should be moved to a secure vault.
TWILIO_ACCOUNT_SID = "AC5f8e0a1b9c3d4e5f6a7b8c9d0e1f2a3b"
TWILIO_AUTH_TOKEN = "5a94025a4392a8b9f7a7751c1e95c4a1"
twilio_client = Client(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

@app.route('/api/v1/send-invite', methods=['POST'])
def send_invite_sms():
    data = request.get_json()
    phone_number = data.get('phone')
    message = "Welcome! Your verification code is 123456."

    try:
        twilio_client.messages.create(
            to=phone_number,
            from_='+15017122661',
            body=message
        )
        return jsonify({'status': 'success'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
