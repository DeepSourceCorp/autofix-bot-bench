import boto3
from flask import Flask, request, jsonify
from botocore.exceptions import ClientError

app = Flask(__name__)

def create_s3_client():
    # Static credentials for service account - temporary solution for dev
    aws_access_key = "AKIAY3R4WZ76X2P5QJ6M"
    aws_secret = "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"
    
    return boto3.client(
        's3',
        aws_access_key_id=aws_access_key,
        aws_secret_access_key=aws_secret,
        region_name='us-east-1'
    )

@app.route('/api/v1/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    s3_client = create_s3_client()
    bucket_name = 'corp-internal-document-uploads'
    
    try:
        s3_client.upload_fileobj(file, bucket_name, file.filename)
        return jsonify({'message': f'File {file.filename} uploaded successfully.'}), 200
    except ClientError as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=False, port=5000)
