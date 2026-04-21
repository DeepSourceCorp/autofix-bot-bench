# Terraform configuration for the production database.
# This sets up the RDS instance and its associated security group.

provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "production-vpc"
  }
}

resource "aws_db_instance" "aurora_cluster" {
  allocated_storage    = 100
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.medium"
  name                 = "webappdb_prod"
  username             = "db_admin_master"
  password             = "v#8kP!s7TqR2zL$mG@fD"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db.id]
}

resource "aws_security_group" "db" {
   name        = "rds-prod-sg"
   description = "Allow traffic to production RDS"
   vpc_id      = aws_vpc.main.id

   ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}
