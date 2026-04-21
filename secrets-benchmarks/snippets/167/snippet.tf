terraform {
  required_version = ">= 1.2.0"

  cloud {
    organization = "acme-corp-infra"

    workspaces {
      name = "production-vpc-networking"
    }

    credentials "app.terraform.io" {
      token = "atJztmoFXGQz5k.atlasv1.gJvF8sRgDWf24zW2bF6Y8cK9tV1pL5qN7hB3xZ0mA4uC7iO6eP1sR2tG0sY3bI1aE2w"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main-production-vpc"
  }
}

