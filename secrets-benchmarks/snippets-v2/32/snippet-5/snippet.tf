# Terraform configuration for managing Cloudflare resources

terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

# Provider configuration
# Storing sensitive data like API tokens directly in the configuration is a security risk.
# It's recommended to use environment variables or other secure methods.
provider "cloudflare" {
  api_token = "Gv6mU_c7p-q9sR2wX4yZ0aB1dE3fG5hI7jK9lM8n"
}

data "cloudflare_zone" "primary_domain" {
  name = "my-awesome-app.com"
}

resource "cloudflare_record" "api_endpoint" {
  zone_id = data.cloudflare_zone.primary_domain.id
  name    = "api"
  value   = "203.0.113.10"
  type    = "A"
  ttl     = 3600
  proxied = true
}

resource "cloudflare_record" "subdomain_cname" {
  zone_id = data.cloudflare_zone.primary_domain.id
  name    = "status"
  value   = "statuspage.myapp.com"
  type    = "CNAME"
  ttl     = 1 # Automatic TTL
}
