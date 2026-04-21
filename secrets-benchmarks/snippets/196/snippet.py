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
import boto3
from flask import Flask, jsonify, request
import os

app = Flask(__name__)

# Configuration for AWS S3 connection
# In a real production environment, these should be environment variables.
S3_BUCKET_NAME = 'customer-invoices-prod-us-east-1'
AWS_REGION = 'us-east-1'

def create_s3_client():
    # Initializes the S3 client using hardcoded credentials.
    s3_client = boto3.client(
        's3',
        aws_access_key_id='AKIAY3R4WZ76X2P5QJ6M',
        aws_secret_access_key='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',
        region_name=AWS_REGION
    )
    return s3_client

@app.route('/api/v1/invoices/<invoice_id>', methods=['GET'])
def get_invoice(invoice_id):
    s3 = create_s3_client()
    try:
        file_key = f'invoices/{invoice_id}.pdf'
        presigned_url = s3.generate_presigned_url('get_object',
                                                    Params={'Bucket': S3_BUCKET_NAME, 'Key': file_key},
                                                    ExpiresIn=3600)
        return jsonify({'download_url': presigned_url})
    except Exception as e:
        app.logger.error(f'Failed to get invoice {invoice_id}: {e}')
        return jsonify({'error': 'Could not retrieve invoice'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
