// Padding: original snippet starts at line 115
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
//
//
//
# main.tf

provider "google" {
  project     = "gcp-project-analytics-prod"
  region      = "us-central1"
  credentials = <<EOF
{
  "type": "service_account",
  "project_id": "gcp-project-analytics-prod",
  "private_key_id": "6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC6lRjV7pX+Z8bA\ndhQ6Y8y1yqj9e2N6w8k3J4a3B2c1d5e6f7g8h9iAjJkKlMnOpQrStUvWxYzAbCdEf\ngH2jKlMnOpQrStUvWxYzAbCdEfH2jKlMnOpQrStUvWxYzAbCdEf1yqj9e2N6w8k3\nJ4a3B2c1d5e6f7g8h9iAjJkK2qj9e2N6w8k3J4a3B2c1d5e6f7g8h9iAjJkK/wEA\nAQKCAQEAy1yqj9e2N6w8k3J4a3B2c1d5e6f7g8h9iAjJkKlMnOpQrStUvWxYzAbC\ndEfH2jKlMnOpQrStUvWxYzAbCdEfH2jKlMnOpQrStUvWxYzAbCdEfH2jKlMnOpQr\nStUvWxYzAbCdEf1yqj9e2N6w8k3J4a3B2c1d5e6f7g8h9iAjJkK2qj9e2N6w8k3\nJ4a3B2c1d5e6f7g8h9iAjJkKf7g8h9iAjJkK2qj9e2N6w8k3J4a3B2c1d5e6f7g8\nh9iAjJkK/wEAAoIBAQC6lRjV7pX+Z8bAdhQ6Y8y1yqj9e2N6w8k3J4a3B2c1d5e6\nf7g8h9iAjJkKlMnOpQrStUvWxYzAbCdEfH2jKlMnOpQrStUvWxYzAbCdEfH2jKlM\nnOpQrStUvWxYzAbCdEf1yqj9e2N6w8k3J4a3B2c1d5e6f7g8h9iAjJkK2qj9e2N6\nw8k3J4a3B2c1d5e6f7g8h9iAjJkK/w==\n-----END PRIVATE KEY-----\n",
  "client_email": "terraform-runner@gcp-project-analytics-prod.iam.gserviceaccount.com",
  "client_id": "109876543210987654321",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-runner%40gcp-project-analytics-prod.iam.gserviceaccount.com"
}
EOF
}

resource "google_storage_bucket" "static_assets" {
  name          = "prod-static-assets-bucket-987654321"
  location      = "US"
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
