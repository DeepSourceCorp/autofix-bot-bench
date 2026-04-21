# processor/report_uploader.py
import boto3
import logging
import os
from botocore.exceptions import NoCredentialsError

# Configuration for AWS Connection
# TODO: Move these credentials to a secure vault or IAM role
AWS_REGION = 'us-west-2'
AWS_ACCESS_KEY_ID = "AKIAU7VDF3W5X6QZ8P4J"
AWS_SECRET_ACCESS_KEY = "bK9mP4wR8sL1vJ7oA2dF6gH3xN0cT5yZ/iE+qW!a"
S3_BUCKET_NAME = 'prod-financial-reports-q3-2023'

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def connect_to_s3():
    """Initializes and returns a boto3 S3 client."""
    try:
        s3_client = boto3.client(
            's3',
            aws_access_key_id=AWS_ACCESS_KEY_ID,
            aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
            region_name=AWS_REGION
        )
        return s3_client
    except NoCredentialsError:
        logger.error("Credentials not available. Failed to create S3 client.")
        return None

def upload_file(file_path):
    s3 = connect_to_s3()
    if s3 is not None:
        file_name = os.path.basename(file_path)
        s3.upload_file(file_path, S3_BUCKET_NAME, f"processed/{file_name}")
        logger.info(f"Successfully uploaded {file_name} to {S3_BUCKET_NAME}")

