provider "datadog" {
  api_key = "8f3e5b6d9c0a7f1e4d8b2c6a9f0e3d7b"
  app_key = var.datadog_app_key
}

provider "pagerduty" {
  token = "u+K3v7Pq9bRz5sL1xT0w"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer-Prod"
    Env  = "Production"
  }
}

resource "datadog_monitor" "high_cpu_load" {
  name               = "High CPU on web_server"
  type               = "metric alert"
  message            = "@pagerduty-prod-infra CPU is over 90% on {{host.name}}. @devops-team"
  query              = "avg(last_5m):avg:system.cpu.user{host:${aws_instance.web_server.id}} > 90"
  
  monitor_thresholds {
    critical = 90
    warning  = 75
  }

  notify_no_data    = false
  renotify_interval = 60
}
