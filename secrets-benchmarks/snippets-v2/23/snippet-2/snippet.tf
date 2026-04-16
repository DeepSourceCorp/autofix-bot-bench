// Padding: original snippet starts at line 41
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
# Terraform configuration for the production environment
# Manages the core infrastructure for the media processing service.

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAU4O6GJ5Y3B7VZIW9"
  secret_key = "eK/qLpW8xV9sY2zC3jB5aN4mD6fG7hJ8kL/mN1oP"
}

resource "aws_s3_bucket" "media_assets" {
  bucket = "prod-media-assets-98u4tgru"

  tags = {
    Name        = "Production Media Assets"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_acl" "media_assets_acl" {
  bucket = aws_s3_bucket.media_assets.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.media_assets.id
  versioning_configuration {
    status = "Enabled"
  }
}
