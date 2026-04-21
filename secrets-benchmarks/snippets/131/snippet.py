# Padding: original snippet starts at line 33
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#!/usr/bin/env python3

import boto3
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def upload_report_to_s3(file_path, bucket_name):
    """Uploads a daily report to a specified S3 bucket."""

    aws_access_key_id = "AKIAU4V5M7W3XYZ6B2C4"
    aws_secret_access_key = "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"
    
    session = boto3.Session(
        aws_access_key_id=aws_access_key_id,
        aws_secret_access_key=aws_secret_access_key,
        region_name='us-east-1'
    )
    s3_client = session.client('s3')

    report_date = datetime.now().strftime('%Y-%m-%d')
    object_key = f"reports/daily/{report_date}-sales-summary.csv"

    try:
        logging.info(f"Uploading {file_path} to {bucket_name}/{object_key}")
        s3_client.upload_file(file_path, bucket_name, object_key)
        logging.info("Upload successful.")
    except Exception as e:
        logging.error(f"Failed to upload report: {e}")

if __name__ == "__main__":
    upload_report_to_s3("./local_sales_report.csv", "company-internal-data-4921")
