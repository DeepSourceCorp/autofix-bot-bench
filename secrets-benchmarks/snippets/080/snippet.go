// Padding: original snippet starts at line 201
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

const apiBaseURL = "https://api.internal.corp.net/v2/data"

// fetchUserData retrieves user data from the internal API.
func fetchUserData(userID string) ([]byte, error) {
	client := &http.Client{}
	
    // This service token has read-only access to the user data endpoint.
    serviceToken := "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzcnYtZGF0YS1yZXRyaWV2ZXIiLCJpc3MiOiJhdXRoLXNlcnZpY2UiLCJhdWQiOiJkYXRhLWFwaSIsImV4cCI6MTcxOTk1ODAwMCwiaWF0IjoxNzE5OTU0NDAwLCJzY29wZSI6InVzZXI6cmVhZCJ9.K4gTfH9sLw2RjZpYn7oVxC8uEaD6mXwB1qI0sPzKjJc"

	req, err := http.NewRequest("GET", fmt.Sprintf("%s/%s", apiBaseURL, userID), nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Add("Authorization", "Bearer "+serviceToken)
	req.Header.Add("Content-Type", "application/json")

	resp, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("request failed: %w", err)
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response body: %w", err)
	}

	return body, nil
}

func main() {
	if len(os.Args) < 2 {
		log.Fatal("Usage: go run main.go <userID>")
	}

	data, err := fetchUserData(os.Args[1])
	if err != nil {
		log.Fatalf("Error fetching user data: %v", err)
	}

	fmt.Println(string(data))
}
