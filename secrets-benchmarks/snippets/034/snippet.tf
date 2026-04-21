# main.tf - Production Infrastructure for Analytics Service

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAT7G3W4LIX5M2P6Q4"
  secret_key = "xZ9cU7sV3mB+pQkL5jH8fG1tY9cRzXvWqSjU3mB/kL"
}

variable "datadog_api_key" {
  type        = string
  description = "Datadog API key for monitoring agent"
  default     = "7e3c98a50616b0b8ad4a835a68729c1d"
}

resource "aws_instance" "analytics_worker" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS
  instance_type = "t3.large"
  count         = 2

  tags = {
    Name    = "analytics-worker-prod"
    Service = "Analytics"
  }

  user_data = <<-EOF
    #!/bin/bash
    DD_API_KEY=${var.datadog_api_key} bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/install_script.sh)"
  EOF
}
