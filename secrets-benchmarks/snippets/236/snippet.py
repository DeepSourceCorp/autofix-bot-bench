import os
import boto3
from flask import Flask, request, jsonify

app = Flask(__name__)

# AWS Session Configuration (should be in env vars)
session = boto3.Session(
    aws_access_key_id='AKIAY3R4WZ76X2P5QJ6M',
    aws_secret_access_key='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY',
    region_name='us-east-1'
)

s3_client = session.client('s3')

@app.route('/api/v1/documents/upload', methods=['POST'])
def upload_document():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    try:
        bucket_name = 'corp-document-archive-prod-01'
        s3_client.upload_fileobj(file, bucket_name, file.filename)
        return jsonify({'status': 'success', 'filename': file.filename}), 201
    except Exception as e:
        app.logger.error(f'S3 upload failed: {e}')
        return jsonify({'error': 'Could not process file'}), 500

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
