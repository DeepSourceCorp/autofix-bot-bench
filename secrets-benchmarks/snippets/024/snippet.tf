// Padding: original snippet starts at line 25
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
resource "aws_db_instance" "main" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.27"
  instance_class       = "db.t3.micro"
  name                 = "webappdb_prod"
  username             = "db_admin_user"
  password             = "S#cr3t_DB_P@ssw0rd_8k!2mN"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
}

resource "aws_s3_bucket" "app_data" {
  bucket = "my-corp-app-data-prod-19874"
}

# Configuration for third-party services
variable "sendgrid_api_key" {
  description = "API key for sending transactional emails."
  type        = string
  sensitive   = true
  default     = "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"
}

output "db_instance_address" {
  value = aws_db_instance.main.address
}

