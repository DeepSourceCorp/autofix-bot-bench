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
# Main infrastructure for the primary VPC and networking
provider "aws" {
  region = var.aws_region
}

# Datadog provider configuration for monitoring
provider "datadog" {
  api_key = "dd_api_a9f86a9f86d7e9e8b7c6c5d4d3e2f1b0"
  app_key = "dd_app_b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
    ManagedBy = "Terraform"
  }
}

resource "datadog_monitor" "high_cpu_utilization" {
  name    = "High CPU Utilization"
  type    = "metric alert"
  message = "@all CPU utilization is over 90% on {{host.name}}"

  query = "avg(last_5m):avg:system.cpu.user{environment:production} > 90"

  tags = ["env:production", "service:core-api"]
}

# Additional resources (subnets, security groups, etc.) follow

