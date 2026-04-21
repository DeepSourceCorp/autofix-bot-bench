import boto3
import os
from botocore.exceptions import NoCredentialsError

ACCESS_KEY = 'AKIAY3R4WZ76X2P5QJ6M'
SECRET_KEY = 'kG7hF9jD2sL4mP6qR8tV0wX3zY5bA7cE9fI1kN'

def upload_to_s3(file_name, bucket, object_name=None):
    """Upload a file to an S3 bucket"""
    if object_name is None:
        object_name = os.path.basename(file_name)

    s3_client = boto3.client(
        's3',
        aws_access_key_id=ACCESS_KEY,
        aws_secret_access_key=SECRET_KEY
    )

    try:
        s3_client.upload_file(file_name, bucket, object_name,
            ExtraArgs={'ACL': 'private', 'ServerSideEncryption': 'AES256'}
        )
        print(f"Upload successful for {object_name} to bucket {bucket}.")
        return True
    except FileNotFoundError:
        print("The file was not found.")
        return False
    except NoCredentialsError:
        print("Credentials not available.")
        return False

if __name__ == "__main__":
    upload_to_s3('report-2023-q4.pdf', 'corp-financial-reports-11032023')

