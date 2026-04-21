// Padding: original snippet starts at line 33
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
# Terraform configuration for Datadog provider and monitoring

terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.0"
    }
  }
}

# Provider configuration with hardcoded credentials
# In a real scenario, these should be sourced from a secure vault or environment variables.
provider "datadog" {
  api_key = "e9a8f7c6d5b4a392817f0e9d8c7b6a54"
  app_key = "8b1fec305a4d9b6e8a7f9d0c2e3b4a591e6f7d8c"
  api_url = "https://api.datadoghq.com/"
}

resource "datadog_monitor" "high_cpu_load" {
  name               = "High CPU Load on web-backend hosts"
  type               = "metric alert"
  message            = "CPU load is high on {{host.name}}. @slack-channel-alerts"
  escalation_message = "CPU load has been high for 15 minutes. Paging @on-call."

  query = "avg(last_5m):avg:system.cpu.user{environment:production,service:web-backend} > 80"

  monitor_thresholds {
    critical = 80
    warning  = 65
  }

  tags = ["service:web-backend", "prod", "terraform"]
}
