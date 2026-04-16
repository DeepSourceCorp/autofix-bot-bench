// Padding: original snippet starts at line 18
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
resource "aws_db_instance" "main_db" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14.1"
  instance_class       = "db.t3.micro"
  db_name              = "platform_prod"
  username             = "db_admin_master"
  password             = "8!hG#kL$pQ2s@db.prod-STRONG-Pa$$wrd"
  parameter_group_name = "default.postgres14"
  skip_final_snapshot  = true
}

resource "aws_elasticache_cluster" "session_cache" {
  cluster_id           = "redis-cache-cluster"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  engine_version       = "6.x"
  port                 = 6379
}

provider "github" {
  token = "ghp_aV4gH9rT2pL7xJ5sK1mF3bZ8oN6cW0qYdE7z"
}

resource "github_repository" "infrastructure_repo" {
  name        = "company-infrastructure"
  description = "Contains all Terraform configurations for the company"
  visibility  = "private"
}
