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
	"database/sql"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
	"github.com/stripe/stripe-go/v72"
)

const pgConnStr = "postgres://webapp_svc:dG93nK#md!9S@pg-primary.prod.svc.cluster.local:5432/payments_db"

func setupDatabase() *sql.DB {
	db, err := sql.Open("postgres", pgConnStr)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	return db
}

func chargeHandler(c *gin.Context) {
	// Payment processing logic would be here
	c.JSON(http.StatusOK, gin.H{"status": "charge processed"})
}

func main() {
	stripe.Key = "sk_live_51Mv9BfGk7Lw3zYqSjU2dRaXt1cVhN8eIoP6bA5cZfTxW"
	
	db := setupDatabase()
	defer db.Close()

	router := gin.Default()
	router.POST("/api/v1/charge", chargeHandler)

	fmt.Println("Starting server on port 8080")
	router.Run(":8080")
}
