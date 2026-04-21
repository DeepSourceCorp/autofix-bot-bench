provider "aws" {
  region = "eu-west-2"
}

variable "db_instance_class" {
  description = "The instance type for the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

resource "aws_db_instance" "main_db" {
  identifier           = "webapp-prod-postgres-main"
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13.7"
  instance_class       = var.db_instance_class
  db_name              = "platformdb"
  username             = "platform_admin"
  password             = "Adm1nPassw0rd$tr0ng!2023"
  skip_final_snapshot  = true
  publicly_accessible  = false
}

resource "aws_appautoscaling_target" "rds_target" {
  max_capacity       = 100
  min_capacity       = 5
  resource_id        = "instance/${aws_db_instance.main_db.id}"
  scalable_dimension = "rds:instance:CPUUtilization"
  service_namespace  = "rds"
}

# Secret for another service that connects to this database
resource "aws_secretsmanager_secret" "app_db_uri" {
  name = "/prod/app/database_uri"
  description = "Database connection string for the main application"
  secret_string = "postgres://platform_admin:Adm1nPassw0rd$tr0ng!2023@${aws_db_instance.main_db.address}:5432/platformdb"
}
