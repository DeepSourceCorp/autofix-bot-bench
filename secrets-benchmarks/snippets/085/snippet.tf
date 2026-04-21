# Terraform configuration for the application's core infrastructure
# Manages the primary RDS instance and a Redis cache cluster.

provider "aws" {
  region     = "eu-west-2"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

resource "aws_db_instance" "main" {
  allocated_storage    = 100
  engine               = "postgres"
  engine_version       = "14.1"
  instance_class       = "db.t3.large"
  db_name              = "app_prod_db"
  username             = "dbmaster"
  password             = "P@ssw0rdDbProd123!ChangeMe"
  parameter_group_name = "default.postgres14"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

resource "aws_elasticache_cluster" "cache" {
  cluster_id           = "app-cache-prod"
  engine               = "redis"
  engine_version       = "6.x"
  node_type            = "cache.t3.medium"
  num_cache_nodes      = 2
  port                 = 6379
  parameter_group_name = "default.redis6.x"
  subnet_group_name    = aws_elasticache_subnet_group.default.name
}

resource "aws_security_group" "db_sg" {
  name        = "db_security_group"
  description = "Allow traffic to the database"
  
  ingress {
    # This should be more restrictive
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
