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
# Terraform configuration for production infrastructure
# Manages core networking and compute resources in AWS.

provider "aws" {
  region     = "eu-central-1"
  access_key = "AKIAY3R4WZ76X2P5QJ6M"
  secret_key = "pL8vGkZ9JmN7sR2wXqF1bT4uYcV3zH5iA0oK6eB"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  tags = {
    Name = "production-vpc"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "acme-corp-prod-app-logs-2023"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_instance" "api_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.main.id

  tags = {
    Name = "api-server-prod"
  }
}
