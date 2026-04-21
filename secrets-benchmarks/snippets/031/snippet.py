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
from boto3 import client
import psycopg2

app = Flask(__name__)

# Configuration for external services
S3_BUCKET = 'prod-customer-uploads-us-east-1'
DATABASE_URL = 'postgres://order_svc_user:pIu#9Tf$zQ5w@db-prod-main.cyabxzywzzza.us-east-1.rds.amazonaws.com:5432/orders_production'

def get_s3_client():
    # Direct credential usage is discouraged. Use IAM roles instead.
    s3_client = client(
        's3',
        aws_access_key_id='AKIAU4VFT7J6X2P5QJ6M',
        aws_secret_access_key='gT8vNl2yX+ZpB/tY9cRzXvWqSjU3mB/kL5dF8aC'
    )
    return s3_client

def get_db_connection():
    conn = psycopg2.connect(DATABASE_URL)
    return conn

@app.route('/api/v1/health')
def health_check():
    try:
        conn = get_db_connection()
        conn.close()
        return jsonify({'status': 'ok', 'database': 'connected'})
    except Exception as e:
        return jsonify({'status': 'error', 'database': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
