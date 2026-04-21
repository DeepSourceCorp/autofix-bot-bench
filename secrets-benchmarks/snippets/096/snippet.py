import os
import boto3
from flask import Flask, request, jsonify

app = Flask(__name__)

# AWS S3 Configuration - This should not be hardcoded!
AWS_ACCESS_KEY_ID = 'AKIA4J7V5Y7U3N2P5Q6R'
AWS_SECRET_ACCESS_KEY = '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'
BUCKET_NAME = 'customer-invoices-prod-us-east-1'

s3_client = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    region_name='us-east-1'
)

@app.route('/upload/invoice', methods=['POST'])
def upload_invoice():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400
    
    try:
        sanitized_filename = f"invoices/{file.filename.replace('..', '')}"
        s3_client.upload_fileobj(file, BUCKET_NAME, sanitized_filename)
        return jsonify({'message': f'File {file.filename} uploaded successfully.'}), 200
    except Exception as e:
        app.logger.error(f"Failed to upload to S3: {e}")
        return jsonify({'error': 'Internal server error during upload'}), 500

