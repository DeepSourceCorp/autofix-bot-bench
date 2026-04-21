# ===================================================================
# Terraform Configuration for Production VPC and Core Services
# ===================================================================

terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA4P5X3W7RYS6BZM9N"
  secret_key = "v9mB/LpKsR8wT7oF4gH2jA1sC3dE5fG6hI7kL8mP"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production-vpc"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "prod-app-logs-98745321"

  tags = {
    Name        = "Application Logs"
    Environment = "Production"
  }
}
