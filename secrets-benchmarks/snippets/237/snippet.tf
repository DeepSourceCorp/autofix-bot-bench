// Padding: original snippet starts at line 21
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
# Terraform configuration for monitoring and cloud provider setup
terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.0"
    }
    google = {
      source = "hashicorp/google"
      version = "4.25.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Datadog provider configuration
# API and App keys for Datadog integration.
provider "datadog" {
  api_key = "dd_api_9f5c2d3a1b0e4f8d6a3c5e7b9a1d3f5c"
  app_key = "dd_app_3e5c7a9b1d3f5c8d2a0b4e6c1d3f5c8d2a0b4"
}

resource "datadog_monitor" "high_cpu_load" {
  name    = "High CPU Load on web-backend-cluster"
  type    = "metric alert"
  message = "@slack-alerts-critical CPU load is over 90% on {{host.name}}. Check running services."
  query   = "avg(last_5m):avg:system.cpu.user{environment:prod} > 90"

  tags = ["service:backend", "env:production"]
}
