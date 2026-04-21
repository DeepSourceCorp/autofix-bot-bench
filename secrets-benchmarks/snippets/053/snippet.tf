provider "aws" {
  region = "eu-central-1"
}

resource "aws_db_instance" "application_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  name                 = "appdbprod"
  username             = "db_admin_master"
  password             = "S3cuRe_dBP@ssw0rd-f0R-Pr0d!2023"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
}

resource "aws_security_group" "db_sg" {
  name        = "db-security-group"
  description = "Allow traffic from application servers"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.private_subnet_ids
}

variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
