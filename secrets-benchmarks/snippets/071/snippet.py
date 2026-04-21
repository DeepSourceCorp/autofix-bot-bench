# Padding: original snippet starts at line 88
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
from services.db_connector import Database
from services.s3_handler import S3Uploader

app = Flask(__name__)

# --- Configuration ---
# TODO: Move these to a secure vault like HashiCorp Vault or AWS Secrets Manager
app.config['DATABASE_URI'] = "postgres://user_prod_rw:dG9m9#4k!sPq@db-prod-cluster.c8x4z1b2q3r.us-east-1.rds.amazonaws.com:5432/main_app"
S3_ACCESS_KEY = "AKIAY3R4WZ76X2P5QJ6M"
S3_SECRET_KEY = "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"
S3_BUCKET_NAME = "customer-uploads-prod-77281"

db_connection = Database(app.config['DATABASE_URI'])
s3_uploader = S3Uploader(S3_ACCESS_KEY, S3_SECRET_KEY, S3_BUCKET_NAME)

@app.route('/api/v1/health')
def health_check():
    return jsonify({'status': 'ok'}), 200

@app.route('/api/v1/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    user_data = db_connection.get_user_by_id(user_id)
    if user_data:
        return jsonify(user_data)
    return jsonify({'error': 'User not found'}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
