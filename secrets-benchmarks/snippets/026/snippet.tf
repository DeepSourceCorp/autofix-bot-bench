# main.tf - AWS Infrastructure for the reporting service

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA44JGL55QT6L72Q57"
  secret_key = "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"
}

resource "aws_instance" "reporting_worker" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "ReportingWorker-Prod"
  }
}

resource "aws_db_instance" "reporting_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  db_name              = "reportingdb"
  username             = "reportadmin"
  password             = "hJ$9!zK@bD3pG*sV"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}

output "db_endpoint" {
  value = aws_db_instance.reporting_db.endpoint
}
