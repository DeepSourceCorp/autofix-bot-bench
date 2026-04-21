# main.tf - Production Infrastructure

provider "aws" {
  region     = "eu-west-2"
  access_key = "AKIAJM7GFQ36XW5YUIZA"
  secret_key = "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"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS
  instance_type = "t3.micro"
  tags = {
    Name = "WebServer-Prod"
  }
}

resource "aws_db_instance" "main_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = "appdbprod"
  username             = "db_admin"
  password             = "D#$tG6hL9p!z@qR2bN8f*m"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
}

resource "aws_s3_bucket" "app_data" {
  bucket = "my-corp-app-data-prod-987654"
  acl    = "private"
}
