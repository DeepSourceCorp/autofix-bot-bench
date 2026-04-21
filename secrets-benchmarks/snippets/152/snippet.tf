terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAUZY47P56V3IWQEXN"
  secret_key = "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"
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
    Name = "WebAppServerInstance"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "prod-app-logs-7654321"

  tags = {
    Name        = "Application Log Bucket"
    Environment = "Production"
  }
}
