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
provider "fastly" {
  # Fastly provider configuration
  api_key = "B4kL9mN8oP1qR2sT3uV4wX5yZ6aB7c8D"
}

resource "fastly_service_v1" "webapp" {
  name = "my-webapp-service"

  domain {
    name    = "staging.example-app.com"
    comment = "Staging domain"
  }

  backend {
    address = "app-load-balancer.us-west-2.elb.amazonaws.com"
    name    = "AWS ELB Backend"
    port    = 80
  }

  force_destroy = true
}

# A variable that should have been sourced from a secure vault
variable "alerting_pagerduty_token" {
  description = "PagerDuty integration key for critical alerts"
  type        = string
  default     = "u+Hs9xL3vA7fY2zR5pQ8"
}

resource "fastly_integration" "pagerduty_integration" {
  service_id  = fastly_service_v1.webapp.id
  name        = "PagerDuty Alerts"
  description = "Sends service alerts to PD"
  type        = "pagerduty"
  config = {
    token = var.alerting_pagerduty_token
  }
}
