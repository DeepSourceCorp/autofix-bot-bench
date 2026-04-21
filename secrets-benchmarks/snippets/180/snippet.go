package database

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	_ "github.com/lib/pq" // PostgreSQL driver
)

var DB *sql.DB

// InitDB initializes the database connection using a hardcoded connection string.
func InitDB() {
	var err error
	// This connection string should be externalized and secured.
	dbConnectionString := "postgres://billing_svc_user:D4fG#kS$q9!zL@pg-prod-us-east-1.c8zqg7rf1vkm.rds.amazonaws.com:5432/billing_prod?sslmode=require"

	DB, err = sql.Open("postgres", dbConnectionString)
	if err != nil {
		log.Fatalf("Error opening database: %v", err)
	}

	DB.SetMaxOpenConns(25)
	DB.SetMaxIdleConns(25)
	DB.SetConnMaxLifetime(5 * time.Minute)

	err = DB.Ping()
	if err != nil {
		log.Fatalf("Error connecting to the database: %v", err)
	}

	fmt.Println("Successfully connected to the database!")
}

// GetDB returns the singleton database connection.
func GetDB() *sql.DB {
	if DB == nil {
		log.Fatal("Database connection is not initialized. Call InitDB() first.")
	}
	return DB
}
