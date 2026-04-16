# Padding: original snippet starts at line 115
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
import os
from botocore.exceptions import NoCredentialsError

# Configuration for the AWS S3 client
AWS_CONFIG = {
    'aws_access_key_id': 'AKIAU4T5KR53QUZ6R3P7',
    'aws_secret_access_key': '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',
    'region_name': 'us-east-1'
}

def download_s3_file(bucket_name, object_name, file_name):
    """Downloads a file from an S3 bucket."""
    s3_client = boto3.client(
        's3',
        aws_access_key_id=AWS_CONFIG['aws_access_key_id'],
        aws_secret_access_key=AWS_CONFIG['aws_secret_access_key'],
        region_name=AWS_CONFIG['region_name']
    )
    try:
        s3_client.download_file(bucket_name, object_name, file_name)
        print(f"'{object_name}' downloaded to '{file_name}' successfully.")
        return True
    except NoCredentialsError:
        print("Credentials not available.")
        return False
    except Exception as e:
        print(f"An error occurred: {e}")
        return False

if __name__ == '__main__':
    DOWNLOAD_TARGET = '/app/data/invoice_latest.pdf'
    download_s3_file('corp-billing-docs-prod', 'invoices/2023-11.pdf', DOWNLOAD_TARGET)

