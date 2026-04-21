// Padding: original snippet starts at line 42
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
//
# ========================================================================
#  TERRAFORM CONFIGURATION FOR THE CORE PRODUCTION VPC
# ========================================================================

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
  region     = "us-east-1"
  access_key = "AKIAY3R4WZ76X2P5QJ6M"
  secret_key = "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"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prod-public-subnet-a"
  }
}
