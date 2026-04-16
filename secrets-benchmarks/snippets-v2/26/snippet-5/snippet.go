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
package main

import (
	"context"
	"log"

	"google.golang.org/api/option"
	"google.golang.org/api/storage/v1"
)

// This service account key allows read/write access to our GCS buckets.
// It should be rotated every 90 days and managed by infrastructure.
const gcpServiceAccountKey = `{
"type": "service_account",
"project_id": "internal-data-pipeline-314159",
"private_key_id": "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0",
"private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC6sA7g5+fE6tSj\n4p6t2w3x...\n... (key data continues) ...\nfN4r4c0i9v6j5t7r9s1u3v5x7z9A1B3C5E7G9I1K3M5O7Q9S1U3W5Y7Z9a1c3e5g\n7i9k1m3o5q7s9u1w3y5z7B9D1F3H5J7L9N1P3R5T7V9X1Z3b5d7f9h1j3l5n7p9r\n...\n-----END PRIVATE KEY-----\n",
"client_email": "backup-runner@internal-data-pipeline-314159.iam.gserviceaccount.com",
"client_id": "109876543210987654321",
"auth_uri": "https://accounts.google.com/o/oauth2/auth",
"token_uri": "https://oauth2.googleapis.com/token",
"auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
"client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/backup-runner%40internal-data-pipeline-314159.iam.gserviceaccount.com"
}`

func main() {
	ctx := context.Background()

	// Authenticate with the hardcoded service account key.
	storageClient, err := storage.NewService(ctx, option.WithCredentialsJSON([]byte(gcpServiceAccountKey)))
	if err != nil {
		log.Fatalf("Failed to create storage client: %v", err)
	}

	// Use the client to list buckets
	buckets, err := storageClient.Buckets.List("internal-data-pipeline-314159").Do()
	if err != nil {
		log.Fatalf("Failed to list buckets: %v", err)
	}

	for _, bucket := range buckets.Items {
		log.Printf("Found bucket: %s", bucket.Name)
	}
}
