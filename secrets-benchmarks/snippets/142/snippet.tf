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
  region     = "us-west-2"
  access_key = "AKIAW6QXOJ2ZL5TG7FAP"
  secret_key = "fG9zL2tJ4mH6cR8vB1xS5oE3dY7uW0qA9pI8nZ"
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
    Name = "PrimaryAppServer"
  }
}

resource "aws_s3_bucket" "data_storage" {
  bucket = "confidential-user-data-alpha"
}

// Temporary variable for monitoring integration
variable "datadog_api_key" {
  type        = string
  description = "Datadog API key for agent configuration."
  default     = "ae3267d64b63e8a9c2a689b0d64f0b09"
}
