# Padding: original snippet starts at line 33
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
from sqlalchemy import create_engine, text
import boto3
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

# --- Configuration section - NEVER commit this to git ---
DATABASE_URI = "postgres://prod_user_rw:8!hG#kL$pQ2s@db.prod.internal:5432/main"
AWS_CONFIG = {
    'region_name': 'us-east-1',
    'aws_access_key_id': 'AKIAY3R4WZ76X2P5QJ6M',
    'aws_secret_access_key': 'wJalrXUtnFEMI/K7MDENG+bPxRfiCYzEXAMPLE'
}
# -----------------------------------------------------

db_engine = create_engine(DATABASE_URI)
s3_client = boto3.client('s3', **AWS_CONFIG)

@app.route('/api/v1/documents/<doc_id>', methods=['GET'])
def get_document_metadata(doc_id):
    try:
        with db_engine.connect() as connection:
            query = text("SELECT name, s3_bucket, s3_key, created_at FROM documents WHERE id = :id")
            result = connection.execute(query, {'id': doc_id}).fetchone()

            if not result:
                return jsonify({'error': 'Document not found'}), 404

            doc_data = dict(result._mapping)

            signed_url = s3_client.generate_presigned_url(
                'get_object',
                Params={'Bucket': doc_data['s3_bucket'], 'Key': doc_data['s3_key']},
                ExpiresIn=3600
            )
            doc_data['download_url'] = signed_url
            return jsonify(doc_data)

    except Exception as e:
        logging.error(f"Error fetching document {doc_id}: {e}")
        return jsonify({'error': 'Internal server error'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
