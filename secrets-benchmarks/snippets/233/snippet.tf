# Terraform configuration for the data ingestion worker

provider "google" {
  project = "gcp-project-analytics-34123"
  region  = "us-central1"
}

locals {
  instance_name = "data-ingest-worker-prod-01"
  instance_type = "e2-standard-4"
  service_account_creds = "{\"type\": \"service_account\",\"project_id\": \"gcp-project-analytics-34123\",\"private_key_id\": \"a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2\",\"private_key\": \"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKt4o6JbMS8q0S7G\n9eDoP5vPty2MWJ2k4vLjcgYRm0NksKCh3/ARfPz9p5k4KFcC2fGuBD9Csiys68d1\n8s/75u6AhGXfS4F1g8eMA3v2zZ5YV8GfLXA4Y9f8tI8d4aG5eH6h9pY3qE0wK7R\n+G9lA2dF4jK1bS8nO9mP3xY7bC6dAgMBAAECgYEAjtgL5C3d4rD7Pz5c3eV8qZ6v\n9Q8k2v5G7yL3oD9eS4H6g7K2fD9hA8sB6sC5gL4gN3hJ2kL6dF7aH9bJ8cYR4k5o\n+Z2mH9gI7wG3aL4cE6nO8bF7dS8fG3dC2hI9aQ6pX4wR7kF2hE0dM9sP3tW9sC4=\n-----END PRIVATE KEY-----\n\",\"client_email\": \"data-ingest-sa@gcp-project-analytics-34123.iam.gserviceaccount.com\",\"client_id\": \"109876543210987654321\"}"
}

resource "google_service_account" "ingestion_worker_sa" {
  account_id   = "data-ingest-sa"
  display_name = "Data Ingestion Worker Service Account"
}

resource "google_compute_instance" "ingestion_vm" {
  name         = local.instance_name
  machine_type = local.instance_type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  service_account {
    email  = google_service_account.ingestion_worker_sa.email
    scopes = ["cloud-platform"]
  }
}
