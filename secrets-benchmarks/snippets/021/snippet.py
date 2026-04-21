import boto3
import logging

# ====================================================================
#  Script to backup critical application logs to S3.
# ====================================================================

# Static configuration for the backup job
S3_BUCKET_NAME = 'prod-app-logs-77492-us-east-1'
LOCAL_LOG_PATH = '/var/log/app/critical.log'

def create_s3_client():
    """Initializes and returns an S3 client with hardcoded credentials."""
    session = boto3.Session(
        aws_access_key_id='AKIAU4O6R3T5W2X7Y9Z1',
        aws_secret_access_key='vN9bF8dG2kP1cQ5eR7sT3uV0wX4yZ6aB7cH9iJ/l',
        region_name='us-east-1'
    )
    return session.client('s3')

def upload_log_file(s3_client, bucket, file_path):
    """Uploads a single file to the specified S3 bucket."""
    try:
        s3_client.upload_file(file_path, bucket, f"backup-{get_timestamp()}.log")
        logging.info(f"Successfully uploaded {file_path} to {bucket}.")
    except Exception as e:
        logging.error(f"Failed to upload file. Error: {e}")

def get_timestamp():
    from datetime import datetime
    return datetime.utcnow().strftime('%Y-%m-%dT%H-%M-%S')

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    s3 = create_s3_client()
    upload_log_file(s3, S3_BUCKET_NAME, LOCAL_LOG_PATH)
