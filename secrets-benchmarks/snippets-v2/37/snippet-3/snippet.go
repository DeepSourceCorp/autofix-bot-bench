// Padding: original snippet starts at line 28
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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
)

var db *sql.DB

func setupDatabase() {
	var err error
	connStr := "postgres://analytics_svc:3#fG&pW9qJ@pg-reporting-cluster.eu-west-1.internal:5432/telemetry_data"
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Error connecting to the database: %v", err)
	}

	err = db.Ping()
	if err != nil {
		log.Fatalf("Error pinging database: %v", err)
	}
	fmt.Println("Successfully connected to the database!")
}

func main() {
	setupDatabase()
	defer db.Close()

	router := gin.Default()
	router.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"status": "ok"})
	})

	router.Run(":8080")
}

