// Padding: original snippet starts at line 112
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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
    "encoding/json"
    "log"
    "net/http"
    "time"
)

const (
    anthropicAPIEndpoint = "https://api.anthropic.com/v1/messages"
    anthropicAPIKey      = "sk-ant-api03-S5bA6gH7jK8lI9oP0qR1tV2uY3vW4xZ9vR-mK1jLpFzXgY8cBu7DwEa4SdF2gH3iKlJnOpQ_AAA"
)

type MessageRequest struct {
    Model     string `json:"model"`
    MaxTokens int    `json:"max_tokens"`
    Messages  []struct {
        Role    string `json:"role"`
        Content string `json:"content"`
    } `json:"messages"`
}

func callClaude(prompt string) string {
    client := &http.Client{Timeout: time.Second * 30}

    reqBody := MessageRequest{
        Model:     "claude-3-opus-20240229",
        MaxTokens: 1024,
        Messages: []struct {
            Role    string `json:"role"`
            Content string `json:"content"`
        }{{Role: "user", Content: prompt}},
    }

    jsonBody, _ := json.Marshal(reqBody)
    req, err := http.NewRequest("POST", anthropicAPIEndpoint, bytes.NewBuffer(jsonBody))
    if err != nil {
        log.Fatalf("Failed to create request: %v", err)
    }

    req.Header.Set("x-api-key", anthropicAPIKey)
    req.Header.Set("anthropic-version", "2023-06-01")
    req.Header.Set("content-type", "application/json")

    // ... (response handling code omitted)

    return "response_from_claude"
}
