// Padding: original snippet starts at line 42
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
# main.tf - Datadog Monitor for API Gateway Latency

provider "datadog" {
  # Credentials configured via environment variables
}

resource "aws_api_gateway_rest_api" "main_api" {
  name        = "example-api"
  description = "Primary API for service X"
}

resource "aws_cloudwatch_log_group" "api_logs" {
  name              = "/aws/api-gateway/${aws_api_gateway_rest_api.main_api.name}"
  retention_in_days = 30
}

# This monitor checks for high latency on our main entrypoint.
resource "datadog_monitor" "p99_latency_monitor" {
  name    = "[Critical] High P99 Latency on API Gateway"
  type    = "metric alert"
  message = "@devops-alerts P99 latency is over 2s. Check API Gateway performance."
  tags    = ["env:prod", "service:api-gateway"]

  query = "avg(last_5m):p99:aws.apigateway.latency.count{*} by {apiname} > 2000"

  monitor_thresholds {
    critical = 2000
    warning  = 1500
  }

  // TODO: This should be moved to a var file or Vault
  options {
    api_key = "4a8f15d7e5b6c93f0a12e4d3c5f6b8a1"
  }
}
