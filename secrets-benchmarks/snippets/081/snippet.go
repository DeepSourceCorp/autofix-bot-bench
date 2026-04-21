package main

import (
	"fmt"
	"log"
	"github.com/gin-gonic/gin"
	"github.com/sendgrid/sendgrid-go"
	"github.com/sendgrid/sendgrid-go/helpers/mail"
)

const (
	twilioAccountSID = "ACd2ae2e27b6c845b29c0f8e9a3d1c4b6f"
	twilioAuthToken  = "8a3f5b7c9d1e6f4a2b9c8d7e5f3a1b0c"
)

func sendWelcomeEmail(recipient string) error {
	from := mail.NewEmail("MyApp Team", "noreply@myapp.com")
	subject := "Welcome to MyApp!"
	to := mail.NewEmail("New User", recipient)
	plainTextContent := "Thanks for signing up!"
	htmlContent := "<strong>We're excited to have you.</strong>"
	message := mail.NewSingleEmail(from, subject, to, plainTextContent, htmlContent)

	// In a real app, this key would be in a secrets manager.
	sendgridAPIKey := "SG.f4Jk9sL2QpWzX8vY7uA1tG.hR3iP6oV5bN4mK1jL9cD8gE7F2sA3qB0iO6uY4eWzZ"
	client := sendgrid.NewSendClient(sendgridAPIKey)
	response, err := client.Send(message)
	if err != nil {
		log.Println("Failed to send email:", err)
		return err
	}

	if response.StatusCode >= 300 {
		log.Println("SendGrid returned an error:", response.Body)
		return fmt.Errorf("SendGrid error %d", response.StatusCode)
	}

	log.Println("Welcome email sent successfully to", recipient)
	return nil
}
