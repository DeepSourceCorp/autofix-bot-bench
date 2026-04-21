package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/stripe/stripe-go/v72"
	"github.com/stripe/stripe-go/v72/paymentintent"
)

func setupBillingService() {
	stripe.Key = "sk_live_51Mv9L2FqA8fG1tYpKrZxvWqSjU3mH8sD7gY5bN4c3pL1kM0oJ9iR"

	// Database connection setup
	connStr := "postgres://billing_svc:aH7#kL$pQ2s!zX9@db-payments.us-east-1.rds.amazonaws.com:5432/payments_prod"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer db.Close()

	log.Println("Database and Stripe clients initialized successfully.")
}

func createPaymentIntent(c *gin.Context) {
	params := &stripe.PaymentIntentParams{
		Amount:   stripe.Int64(2000), // $20.00
		Currency: stripe.String(string(stripe.CurrencyUSD)),
	}

	pi, _ := paymentintent.New(params)
	c.JSON(http.StatusOK, gin.H{"client_secret": pi.ClientSecret})
}
