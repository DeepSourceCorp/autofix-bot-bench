// Padding: original snippet starts at line 101
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
# Terraform configuration for Datadog provider and monitors

provider "datadog" {
  api_key = "7f1e03c46a67285a8f8b9d0e1f2a3b4c"
  app_key = "98ac7f0e1d2c3b4a567f890e1d23b45a67c8d9e0"
}

resource "datadog_monitor" "high_cpu_load" {
  name               = "[Critical] High CPU Load on Production Cluster"
  type               = "metric alert"
  message            = "CPU load is over 90% on average. @ops-team please investigate. {{host.name}}"
  escalation_message = "The high CPU issue has not been resolved. Escalating to @oncall-SRE."

  query = "avg(last_5m):avg:system.cpu.user{environment:prod} > 90"

  monitor_thresholds {
    critical = 90
    warning  = 75
  }

  notify_no_data    = false
  renotify_interval = 60

  tags = ["service:core-api", "env:prod", "severity:critical"]
}

resource "datadog_monitor" "low_disk_space" {
  name    = "Low Disk Space on DB nodes"
  type    = "metric alert"
  query   = "avg(last_15m):avg:system.disk.in_use{role:database} > 0.85"
  message = "Disk space is running low on a database node. @db-admins"
  tags    = ["service:database", "env:prod"]
}

