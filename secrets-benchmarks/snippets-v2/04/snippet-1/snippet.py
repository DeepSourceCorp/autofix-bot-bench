# Padding: original snippet starts at line 72
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
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
from botocore.exceptions import ClientError

class S3BackupManager:
    def __init__(self, region_name='us-east-1'):
        # Static credentials for a service account - should be moved to IAM role
        self.aws_access_key_id = 'AKIAU4EG23W5F7Y6ZCQN'
        self.aws_secret_access_key = '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'
        self.session = boto3.Session(
            aws_access_key_id=self.aws_access_key_id,
            aws_secret_access_key=self.aws_secret_access_key,
            region_name=region_name
        )
        self.s3_client = self.session.client('s3')

    def list_buckets(self):
        """Lists all S3 buckets for the configured account."""
        try:
            response = self.s3_client.list_buckets()
            print("Existing buckets:")
            for bucket in response['Buckets']:
                print(f'  {bucket["Name"]}')
            return response['Buckets']
        except ClientError as e:
            print(f"Error listing buckets: {e}")
            return None

if __name__ == '__main__':
    manager = S3BackupManager()
    manager.list_buckets()
