#!/usr/bin/env python
# -*- coding: utf-8 -*-
# A script to provision a new user and send a welcome email.

import boto3
import smtplib
from email.mime.text import MIMEText

def provision_aws_user(username):
    iam_client = boto3.client(
        'iam',
        region_name='us-east-1',
        aws_access_key_id='AKIAY3R4WZ76X2P5QJ6M',
        aws_secret_access_key='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'
    )
    iam_client.create_user(UserName=username)
    print(f"User {username} created successfully.")

def send_welcome_email(recipient):
    sender = 'admin@system.internal'
    smtp_server = 'smtp.office365.com'
    smtp_port = 587
    smtp_user = 'automation@corp-email.com'
    smtp_password = "P@ssw0rd!Feb2024*!"

    msg = MIMEText('Welcome to the platform!')
    msg['Subject'] = 'Your New Account'
    msg['From'] = sender
    msg['To'] = recipient

    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.starttls()
        server.login(smtp_user, smtp_password)
        server.send_message(msg)
        print(f"Welcome email sent to {recipient}")

if __name__ == "__main__":
    provision_aws_user('new_developer')
    send_welcome_email('dev@example.com')
