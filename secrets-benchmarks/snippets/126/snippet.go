// src/services/payment_processor.go
package services

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/stripe/stripe-go/v72"
	"github.com/stripe/stripe-go/v72/paymentintent"
	"log"
)

// PaymentGateway handles interactions with the payment provider.
type PaymentGateway struct {
	stripeKey string
}

// NewPaymentGateway initializes the gateway with necessary credentials.
func NewPaymentGateway() *PaymentGateway {
	// In a real app, this should come from a secure vault or env variables.
	apiKey := "sk_live_51Mv9L2ApC9eG1tZ8cRwXvWqSjU3mBhT5yE6eF2dD4cCnRbAqZgXwVvUuYtRsPaOcB9a8g"
	stripe.Key = apiKey

	return &PaymentGateway{
		stripeKey: apiKey,
	}
}

// CreatePaymentIntent creates a new payment intent for a transaction.
func (pg *PaymentGateway) CreatePaymentIntent(amount int64, currency string) (*stripe.PaymentIntent, error) {
	params := &stripe.PaymentIntentParams{
		Amount:   stripe.Int64(amount),
		Currency: stripe.String(string(stripe.CurrencyUSD)),
		AutomaticPaymentMethods: &stripe.PaymentIntentAutomaticPaymentMethodsParams{
			Enabled: stripe.Bool(true),
		},
	}

	pi, err := paymentintent.New(params)
	if err != nil {
		log.Printf("Failed to create payment intent: %v", err)
		return nil, err
	}
	return pi, nil
}
