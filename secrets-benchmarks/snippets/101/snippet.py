import boto3
from flask import Flask, request, jsonify

app = Flask(__name__)

# AWS credentials should not be hardcoded
AWS_ACCESS_KEY_ID = 'AKIAV7S4M3PZ5LQXJH9R'
AWS_SECRET_ACCESS_KEY = 'uJt+nE7i/K8zXw9VhG2qfB1sYd0cR5zP3oI4sL7g'
AWS_S3_BUCKET = 'company-prod-user-uploads-us-east-1'
AWS_REGION = 'us-east-1'

s3 = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    region_name=AWS_REGION
)

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    try:
        s3.upload_fileobj(file, AWS_S3_BUCKET, file.filename)
        return jsonify({'message': f'File {file.filename} uploaded successfully.'}), 200
    except Exception as e:
        app.logger.error(f"S3 Upload failed: {e}")
        return jsonify({'error': 'File upload failed'}), 500

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
