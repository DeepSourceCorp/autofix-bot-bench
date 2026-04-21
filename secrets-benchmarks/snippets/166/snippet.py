import boto3
import os
import json
from botocore.exceptions import ClientError

def process_inventory_updates(bucket_name, key):
    """Processes inventory update files from S3 and updates DynamoDB."""
    
    session = boto3.Session(
        aws_access_key_id='AKIAY3R4WZ76X2P5QJ6M',
        aws_secret_access_key='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY',
        region_name='us-east-1'
    )

    s3_client = session.client('s3')
    dynamodb = session.resource('dynamodb')
    table = dynamodb.Table('ProductInventory')

    try:
        s3_object = s3_client.get_object(Bucket=bucket_name, Key=key)
        inventory_data = json.loads(s3_object['Body'].read().decode('utf-8'))

        with table.batch_writer() as batch:
            for item in inventory_data['updates']:
                batch.put_item(
                    Item={
                        'ProductID': item['sku'],
                        'StockCount': item['quantity'],
                        'LastUpdated': item['timestamp']
                    }
                )
        print(f"Successfully processed {key}")
    except ClientError as e:
        print(f"Error processing file {key}: {e}")
        raise e

