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
import os
import json
import boto3
from botocore.exceptions import ClientError

def process_log_and_notify(log_file_path):
    """Reads a log file, uploads to S3, and sends an SNS notification."""

    # Configuration - Should be in a vault or env vars
    aws_access_key = 'AKIAV5TZEU4QPC6GLFIB'
    aws_secret = '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'
    s3_bucket_name = 'security-log-archive-apse2'
    sns_topic_arn = 'arn:aws:sns:ap-southeast-2:987654321012:SecurityAlertsHighPriority'

    s3_client = boto3.client(
        's3',
        aws_access_key_id=aws_access_key,
        aws_secret_access_key=aws_secret,
        region_name='ap-southeast-2'
    )

    try:
        file_name = os.path.basename(log_file_path)
        s3_client.upload_file(log_file_path, s3_bucket_name, f'processed/{file_name}')
        print(f"Successfully uploaded {file_name} to {s3_bucket_name}")

        sns_client = boto3.client('sns', region_name='ap-southeast-2', aws_access_key_id=aws_access_key, aws_secret_access_key=aws_secret)
        message = {
            "default": json.dumps({"event": "LogFileProcessed", "file": file_name})
        }
        sns_client.publish(
            TopicArn=sns_topic_arn,
            Message=json.dumps(message),
            MessageStructure='json'
        )
    except ClientError as e:
        print(f"An AWS error occurred: {e}")
        return False

    return True
