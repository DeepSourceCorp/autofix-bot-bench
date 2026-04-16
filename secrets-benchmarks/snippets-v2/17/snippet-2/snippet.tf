// Padding: original snippet starts at line 41
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
# ===================================================================
# Terraform configuration for the staging database
# ===================================================================

provider "aws" {
  region = "eu-west-2"
}

resource "aws_db_instance" "user_data_db_staging" {
  identifier             = "user-data-db-staging-instance"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "14.2"
  name                   = "userdb_staging"
  username               = "stg_db_admin"
  password               = "E#u8!pS$t9rWbK@zL7m3vN&yQ2xH"
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  tags = {
    Environment = "Staging"
    Project     = "UserDataService"
    ManagedBy   = "Terraform"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db-sg-staging"
  description = "Allow traffic to staging DB from app tier"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.app_tier_cidr]
  }
}
