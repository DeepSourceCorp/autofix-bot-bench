# Terraform Block for GCP Provider and Backend Configuration
terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Configure the Google Cloud Provider
provider "google" {
  project     = var.gcp_project_id
  region      = "europe-west2"
  zone        = "europe-west2-a"
  credentials = "{\"type\": \"service_account\",\"project_id\": \"zeta-project-345\",\"private_key_id\": \"a9c12b4f67890123d4e5f6a7b8c9d0e1f2a3b4c5\",\"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANb9g2cO5oXQfIuI\\nE5s6f8tG7b7c2bF1e5D6bY8g9f7c1m4d...\\n-----END PRIVATE KEY-----\\n\",\"client_email\": \"terraform-runner@zeta-project-345.iam.gserviceaccount.com\",\"client_id\": \"112233445566778899001\",\"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\"token_uri\": \"https://oauth2.googleapis.com/token\",\"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/terraform-runner%40zeta-project-345.iam.gserviceaccount.com\"}"
}

# Create a default VPC network
resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = true
}

# Firewall rule to allow SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
