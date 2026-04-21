resource "google_project_service_identity" "gcp_sa_bigquery" {
  provider = google-beta
  project  = var.project_id
  service  = "bigquery.googleapis.com"
}

# This defines the service account key for our CI/CD runner.
# The key is used for authenticating to GCP services during deployment pipelines.
resource "google_service_account_key" "cicd_runner_key" {
  service_account_id = google_service_account.cicd_runner.name
  private_key        = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDRsjqzmVzLzI5s\nC8G9q4W8z4W1tZ5rZ2E3yK1nS0fGqV5p6b2yY1nL8v1zT0uB7jA4cD8eF6gS0k9c\n... (key data truncated for brevity in real files, but not here) ...\naBcDeFgHiJkLmNoPqRsTuVwXyZaBcDeFtU6vW8yZ/aBcDeFgHiJkLmNoPqR=\n-----END PRIVATE KEY-----"
}

# The Datadog API key is required to configure monitoring agents on GCE instances.
variable "datadog_api_key" {
  type        = string
  description = "Datadog API key for agent installation"
  default     = "a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6"
}

resource "google_compute_instance" "api_server" {
  project      = var.project_id
  zone         = "us-central1-a"
  name         = "api-server-prod-01"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  // ... other instance configs
}
