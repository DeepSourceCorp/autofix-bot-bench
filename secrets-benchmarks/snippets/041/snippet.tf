// Padding: original snippet starts at line 15
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
# main.tf - AWS Infrastructure for the reporting service

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAYJ5U4F6X3W2Z7Q8B"
  secret_key = "vG9dK8jFpQ4sH7wB2uA1tY6zC0xL5nE3bV2mO4iP"
}

resource "aws_instance" "reporting_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_internal.id]

  tags = {
    Name        = "Reporting-Instance-Prod"
    Environment = "Production"
  }
}

resource "aws_db_instance" "analytics_db" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13.3"
  instance_class       = "db.t3.micro"
  name                 = "analyticsdb_prod"
  username             = "dbadmin"
  password             = var.db_password # Injected from CI
  skip_final_snapshot  = true
}

resource "aws_s3_bucket" "data_lake" {
  bucket = "prod-analytics-data-lake-987345"

  tags = {
    Name = "Data Lake Bucket"
  }
}
