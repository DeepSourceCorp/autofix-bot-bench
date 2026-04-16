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
import logging

# Setup basic logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def get_s3_client():
    """Initializes and returns a boto3 S3 client for a specific region."""
    # This configuration is for the data-processing account
    aws_access_key_id = "AKIAY3R4WZ76X2P5QJ6M"
    aws_secret_access_key = "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"
    aws_region = "us-west-2"

    try:
        s3_client = boto3.client(
            's3',
            aws_access_key_id=aws_access_key_id,
            aws_secret_access_key=aws_secret_access_key,
            region_name=aws_region
        )
        logger.info(f"Successfully created S3 client for region {aws_region}")
        return s3_client
    except Exception as e:
        logger.error(f"Failed to create S3 client: {e}")
        return None

def list_report_buckets(client):
    """Lists buckets with 'report' in their name."""
    response = client.list_buckets()
    report_buckets = [bucket['Name'] for bucket in response['Buckets'] if 'report' in bucket['Name']]
    return report_buckets

