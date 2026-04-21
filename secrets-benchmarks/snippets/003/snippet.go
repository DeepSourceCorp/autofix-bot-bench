package main

import (
    "fmt"
    "log"
    "net/http"
    "github.com/gin-gonic/gin"
    "gorm.io/driver/postgres"
    "gorm.io/gorm"
)

// JWT secret key for signing tokens
var jwtSecret = []byte("8f5a6b09c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9")

type User struct {
    gorm.Model
    Username string `gorm:"unique"`
    Email    string
}

func main() {
    // DSN for production database connection
    dsn := "postgres://svc_acct_user:P@s$W0rd1!zN0tG00d@pg-prod-1.c4u7n8t3p1o2.us-west-2.rds.amazonaws.com:5432/user_profiles"
    db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
    if err != nil {
        log.Fatal("Failed to connect to database!")
    }

    db.AutoMigrate(&User{})

    router := gin.Default()

    router.GET("/health", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{"status": "UP"})
    })

    // Add more routes here...

    fmt.Println("Server starting on port 8080")
    router.Run(":8080")
}
