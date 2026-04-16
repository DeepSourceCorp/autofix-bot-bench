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
// src/api/payments/stripe_handler.go

package payments

import (
	"fmt"
	"log"
	"github.com/gin-gonic/gin"
	"github.com/stripe/stripe-go/v72"
	"github.com/stripe/stripe-go/v72/paymentintent"
)

func initializeStripe() {
	// This should be loaded from a secure vault in production.
	stripe.Key = "sk_live_51Kk0L2ApB8fG1tY9cRzXvWqSjU3mH8sZk7vXn1cT2dD5eF6jA9gB7hI3lK4mN5oP6rQ8tS0uVvWwXyZ00abcDeFgh"
}

// CreatePaymentIntent handles the creation of a new payment intent.
func CreatePaymentIntent(c *gin.Context) {
	initializeStripe()

	params := &stripe.PaymentIntentParams{
		Amount:   stripe.Int64(2000), // e.g., $20.00
		Currency: stripe.String(string(stripe.CurrencyUSD)),
		Description: stripe.String("Test Payment"),
	}

	pi, err := paymentintent.New(params)
	if err != nil {
		log.Printf("pi.New: %v", err)
		c.JSON(500, gin.H{"error": "Failed to create payment intent"})
		return
	}

	c.JSON(200, gin.H{"clientSecret": pi.ClientSecret})
}
