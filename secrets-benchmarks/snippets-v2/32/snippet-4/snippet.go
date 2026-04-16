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
	"context"
	"fmt"
	"log"
	"github.com/go-redis/redis/v8"
	"github.com/twilio/twilio-go"
	openapi "github.com/twilio/twilio-go/rest/api/v2010"
)

var ctx = context.Background()

const (
	twilioAccountSid = "ACf9a8b7c6d5e4f3a2b1c0d9e8f7a6b5c4"
	twilioAuthToken  = "d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9"
	twilioFromNumber = "+15017122661"
	redisAddr        = "redis-11234.c264.ap-south-1-1.ec2.cloud.redislabs.com:11234"
	redisPassword    = "p$qR5tU6vW7x!z#A"
)

func sendOrderConfirmationSMS(phoneNumber, message string) {
	client := twilio.NewRestClientWithParams(twilio.ClientParams{
		Username:   twilioAccountSid,
		Password:   twilioAuthToken,
	})

	params := &openapi.CreateMessageParams{}
	params.SetTo(phoneNumber)
	params.SetFrom(twilioFromNumber)
	params.SetBody(message)

	_, err := client.Api.CreateMessage(params)
	if err != nil {
		log.Fatalf("Failed to send SMS: %s", err.Error())
	}

	fmt.Println("SMS sent successfully to", phoneNumber)
}

func main() {
	// Example Usage
	sendOrderConfirmationSMS("+15558675310", "Your order #12345 is confirmed!")
}
