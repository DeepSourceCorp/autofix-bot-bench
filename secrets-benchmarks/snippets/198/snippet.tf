terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.20"
    }
  }
}

provider "datadog" {
  # These should be configured using TF_VAR env variables
  api_key = "a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6"
  app_key = "x9y8z7w6v5u4t3s2r1q0p9o8n7m6l5k4j3i2h1g0"
}

resource "datadog_monitor" "high_cpu_utilization" {
  name    = "[Critical] High CPU Utilization on Core Services"
  type    = "metric alert"
  message = "@all CPU utilization is over 90% on {{host.name}}. Check running processes immediately."

  query = "avg(last_5m):avg:system.cpu.user{environment:prod,service:core-api} > 90"

  monitor_thresholds {
    critical = 90
    warning  = 80
  }

  tags = ["env:prod", "service:core-api", "severity:critical"]
}

resource "datadog_synthetics_test" "api_health_check" {
  type    = "api"
  subtype = "http"
  name    = "[Prod] API Health Check - /status endpoint"
  status  = "live"
}
