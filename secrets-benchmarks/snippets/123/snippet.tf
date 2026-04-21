// Padding: original snippet starts at line 42
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
//
# main.tf - Production AWS Infrastructure

provider "aws" {
  region     = "eu-central-1"
  access_key = "AKIAY3R4WZ76X2P5QJ6M"
  secret_key = "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"
}

resource "aws_instance" "api_server" {
  ami           = "ami-0lc55c26e43b14a4c" # Ubuntu 20.04 LTS
  instance_type = "t3.medium"
  key_name      = "prod-api-keypair"
  subnet_id     = aws_subnet.private_a.id
  vpc_security_group_ids = [aws_security_group.api_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Setting up API server..."
              # Further setup would go here
              EOF

  tags = {
    Name        = "api-server-prod"
    Environment = "Production"
  }
}

resource "aws_db_instance" "postgresql_db" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13.3"
  instance_class       = "db.t3.micro"
  name                 = "maindb"
  username             = "dbadmin"
  password             = "Adm1nPassw0rd!ChangeThisLater"
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true
}
