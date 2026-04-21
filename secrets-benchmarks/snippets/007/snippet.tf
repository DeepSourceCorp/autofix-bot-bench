provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAY3R4WZ76X2P5QJ6M"
  secret_key = "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"
}

resource "aws_s3_bucket" "customer_uploads" {
  bucket = "app-customer-uploads-prod-0a1b2c"
  acl    = "private"

  tags = {
    Name        = "Customer Uploads Bucket"
    Environment = "Production"
  }
}

resource "aws_db_instance" "app_database" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = "webappdb_prod"
  username             = "db_admin"
  password             = "db_P@ssw0rd_pr0d_!2023"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
}

