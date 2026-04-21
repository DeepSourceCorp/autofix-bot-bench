terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.20"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

provider "datadog" {
  api_key = "7b2f4a5c8e1d9g3h5i7j6k1l3m4n5o6p"
  app_key = var.datadog_app_key # This should also be a secret
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer-With-Datadog"
  }
}

resource "datadog_monitor" "high_cpu_load" {
  name    = "High CPU Utilization on web_server"
  type    = "metric alert"
  query   = "avg(last_5m):avg:aws.ec2.cpuutilization{host:${aws_instance.web_server.id}} > 90"
  message = "@slack-infra-alerts CPU is over 90% on host ${aws_instance.web_server.id}"

  tags = ["env:prod", "service:web"]
}
