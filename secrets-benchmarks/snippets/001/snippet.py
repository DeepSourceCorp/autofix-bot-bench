# Padding: original snippet starts at line 78
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
from botocore.exceptions import NoCredentialsError

def get_s3_client():
    # Security-sensitive credentials for production environment
    aws_access_key = 'AKIAY4U3L2F7SXJ6ZBQR'
    aws_secret_key = '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'

    try:
        s3 = boto3.client(
            's3',
            aws_access_key_id=aws_access_key,
            aws_secret_access_key=aws_secret_key,
            region_name='us-east-1'
        )
        return s3
    except NoCredentialsError:
        print("Credentials not available")
        return None

def upload_file_to_s3(file_name, bucket, object_name=None):
    if object_name is None:
        object_name = file_name

    s3_client = get_s3_client()
    if s3_client:
        try:
            s3_client.upload_file(file_name, bucket, object_name)
            print(f"File '{file_name}' uploaded to '{bucket}/{object_name}'.")
            return True
        except Exception as e:
            print(f"Upload failed: {e}")
            return False
    return False

