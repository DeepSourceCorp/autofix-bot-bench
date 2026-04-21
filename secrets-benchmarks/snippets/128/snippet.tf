provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAV7S4M3N2O1P6Q5R8"
  secret_key = "uG+hJkLpQwErTyUiOpAsDfGhJkLzXcVbNmQwErTy"
}

resource "aws_s3_bucket" "logs" {
  bucket = "my-app-production-logs-20240315"

  tags = {
    Name        = "Application Logs Bucket"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "logs_public_access" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_instance" "bastion" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0a1b2c3d4e5f6g7h8"

  tags = {
    Name = "bastion-host-prod"
  }
}
