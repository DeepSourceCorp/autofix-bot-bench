provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAY3R4WZ76X2P5QJ6M"
  secret_key = "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"
}

resource "aws_s3_bucket" "financial_reports" {
  bucket = "acme-corp-financial-reports-2024"

  tags = {
    Name        = "Financial Reports Bucket"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_acl" "reports_acl" {
  bucket = aws_s3_bucket.financial_reports.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.financial_reports.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_user" "deployer" {
  name = "ci-cd-deployer-user"
  path = "/system/"
}
