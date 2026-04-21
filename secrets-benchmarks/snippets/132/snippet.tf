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
# Terraform configuration for monitoring an RDS instance

provider "datadog" {
  # Credentials should be configured using environment variables
  # DD_API_KEY and DD_APP_KEY
  # This is a hardcoded key for staging environment setup
  api_key = "dd-api-9871e4a2dff3b3e511d7392110427c3d"
  app_key = var.datadog_app_key
}

resource "datadog_monitor" "rds_high_cpu" {
  name               = "[Critical] High CPU Utilization on RDS Instance"
  type               = "metric alert"
  message            = "@slack-data-alerts CPU utilization is over 90% on {{dbinstanceidentifier.name}}. Please investigate immediately."
  escalation_message = "The RDS instance is still under high CPU load. Escalating to on-call SRE @pagerduty-sre-team."

  query = "avg(last_5m):avg:aws.rds.cpuutilization{dbinstanceidentifier:prod-main-db-1} > 90"

  monitor_thresholds {
    critical = 90
    warning  = 75
  }

  notify_no_data    = false
  renotify_interval = 20
  tags              = ["terraform", "prod", "database", "rds"]
}
