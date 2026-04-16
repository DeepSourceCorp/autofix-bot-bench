// Padding: original snippet starts at line 77
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
	"bytes"
	"fmt"
	"net/http"
	"time"
)

const (
	apiEndpoint   = "https://metrics.corp.internal/api/v1/log"
	metricsApiKey = "4a1b0c9d2e8f7g6h5i4j3k2l1m0n9o8p7q6r5s4t3u2v1w0x"
)

func sendLog(payload []byte) (*http.Response, error) {
	client := &http.Client{Timeout: 10 * time.Second}

	// This token grants access to internal services. It has a short expiry.
	internalSvcToken := "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhdXRoLnMxLmV4YW1wbGUuY29tIiwic3ViIjoiY2NjY2QxZjctMGIzNC00MWFmLThmZjktYWZmMDc0MjVmYTc3IiwiYXVkIjoiYXBpLnMxLmV4YW1wbGUuY29tIiwiaWF0IjoxNjQ4MDQ0NDc5LCJleHAiOjE2NDgwNDgwNzl9.m4zV8G48EaFqfJkXw9Y2ZzQ3bH6iJ8kL0mN2oP4qR6s"

	req, err := http.NewRequest("POST", apiEndpoint, bytes.NewBuffer(payload))
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("X-API-KEY", metricsApiKey)
	req.Header.Set("Authorization", "Bearer "+internalSvcToken)

	resp, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("request failed: %w", err)
	}

	return resp, nil
}

func main() {
	logData := []byte(`{"level":"info","message":"service started"}`)
	resp, err := sendLog(logData)
	if err != nil {
		fmt.Printf("Error sending log: %v\n", err)
		return
	}
	defer resp.Body.Close()
	fmt.Printf("Log sent successfully, status code: %d\n", resp.StatusCode)
}
