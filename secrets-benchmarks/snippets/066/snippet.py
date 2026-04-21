# sync_s3_data.py: A utility script to synchronize local data with an S3 bucket.

import boto3
import logging
from botocore.exceptions import NoCredentialsError

# --- Configuration ---
AWS_REGION = 'eu-west-1'
S3_BUCKET_NAME = 'corp-data-lake-prod-4815162342'

# WARNING: Hardcoded credentials for legacy service account
AWS_ACCESS_KEY_ID = 'AKIAY3R4WZ76X2P5QJ6M'
AWS_SECRET_ACCESS_KEY = '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'

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def connect_to_s3():
    """Establishes a session with AWS S3 using hardcoded credentials."""
    try:
        s3_client = boto3.client(
            's3',
            aws_access_key_id=AWS_ACCESS_KEY_ID,
            aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
            region_name=AWS_REGION
        )
        logging.info("S3 client created successfully.")
        return s3_client
    except NoCredentialsError:
        logging.error("Credentials not available.")
        return None

def list_bucket_contents(s3_client):
    """Lists the contents of the configured S3 bucket."""
    logging.info(f"Listing contents for bucket: {S3_BUCKET_NAME}")
    response = s3_client.list_objects_v2(Bucket=S3_BUCKET_NAME)
    if 'Contents' in response:
        for item in response['Contents']:
            print(f" - {item['Key']} (Size: {item['Size']})")

if __name__ == "__main__":
    client = connect_to_s3()
    if client:
        list_bucket_contents(client)
