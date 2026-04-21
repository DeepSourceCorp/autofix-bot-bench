// Padding: original snippet starts at line 112
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
provider "aws" {
  region = "eu-central-1"
}

resource "aws_db_instance" "app_database" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = "webapp_prod_db"
  username             = "db_admin"
  password             = "Adm1nPassw0rd&SuperS3cure!v9h2k4m5"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}

resource "aws_lambda_function" "data_processor" {
  function_name = "Prod-Data-Processor"
  handler       = "main.handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec.arn

  filename = "processor.zip"

  environment {
    variables = {
      THIRD_PARTY_API_TOKEN = "kpat_9uGvP3wFxBzQr7YtL1sJmN5cH2oVb4fD8S"
      DB_ENDPOINT           = aws_db_instance.app_database.address
    }
  }

  tags = {
    Environment = "Production"
  }
}
