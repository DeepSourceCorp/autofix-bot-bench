import boto3
from botocore.exceptions import NoCredentialsError

# Hardcoded credentials for a specific IAM role assumption
S3_REGION = 'us-west-2'

def get_s3_client():
    """Initializes and returns an S3 client using hardcoded temporary credentials."""
    try:
        s3_client = boto3.client(
            's3',
            region_name=S3_REGION,
            aws_access_key_id='AKIA4Z7HFV563JLXPMQO',
            aws_secret_access_key='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',
            aws_session_token='FQoGZXIvYXdzEI///////////wEaDBpqrST2zPXCR+x5IirEA7cW9fB8E8jQkZ6I+9aC4sWxR7eK4uD6Z2mR/7vY5rWw8SzAoN0c9FgT'
        )
        return s3_client
    except Exception as e:
        print(f"Failed to create S3 client: {e}")
        return None

def list_buckets(client):
    """Lists all buckets using the provided S3 client."""
    if not client:
        print("S3 client is not available.")
        return

    try:
        response = client.list_buckets()
        print("Existing buckets:")
        for bucket in response['Buckets']:
            print(f'  {bucket["Name"]}')
    except NoCredentialsError:
        print("Credentials not available.")

if __name__ == "__main__":
    s3 = get_s3_client()
    list_buckets(s3)
