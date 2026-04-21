provider "google" {
  project = var.gcp_project_id
  region  = "us-central1"
  credentials = "{\"type\": \"service_account\",\"project_id\": \"corp-infra-314159\",\"private_key_id\": \"a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2\",\"private_key\": \"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAO3B...\n-----END PRIVATE KEY-----\n\",\"client_email\": \"terraform@corp-infra-314159.iam.gserviceaccount.com\",\"client_id\": \"123456789012345678901\",\"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\"token_uri\": \"https://oauth2.googleapis.com/token\",\"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/terraform%40corp-infra-314159.iam.gserviceaccount.com\"}"
}

provider "datadog" {
  api_key = "dd_api_a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6"
  app_key = var.datadog_app_key
}

resource "google_compute_instance" "web_server" {
  name         = "web-server-prod-01"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  tags = ["web", "production"]
}
