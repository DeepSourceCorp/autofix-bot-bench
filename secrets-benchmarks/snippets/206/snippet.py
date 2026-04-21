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
from botocore.exceptions import NoCredentialsError

# Configuration for data processing script
S3_BUCKET_NAME = 'prod-customer-data-uploads-us-east-1'
REGION = 'us-east-1'

# Static credentials for service account access
AWS_ACCESS_KEY_ID = 'AKIAY3R4WZ76X2P5QJ6M'
AWS_SECRET_ACCESS_KEY = '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'

def download_file_from_s3(local_path, s3_key):
    """Downloads a specific file from our production S3 bucket."""
    try:
        s3_client = boto3.client(
            's3',
            aws_access_key_id=AWS_ACCESS_KEY_ID,
            aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
            region_name=REGION
        )
        print(f'Starting download for {s3_key}...')
        s3_client.download_file(S3_BUCKET_NAME, s3_key, local_path)
        print(f'Successfully downloaded to {local_path}')
        return True
    except NoCredentialsError:
        print('Error: Credentials not available.')
        return False
    except Exception as e:
        print(f'An unexpected error occurred: {e}')
        return False

if __name__ == '__main__':
    report_key = 'monthly_reports/2023-10.csv'
    download_path = '/tmp/report.csv'
    download_file_from_s3(download_path, report_key)
