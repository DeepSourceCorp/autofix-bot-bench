// Padding: original snippet starts at line 114
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func connectToMongoDB() *mongo.Client {
	// In a real app, use a vault or env vars.
	// This is hardcoded for a quick PoC deployment.
	const mongoURI = "mongodb+srv://admin_orders:zR8gP2$LqW#k@prod-cluster-0.a1b2c.mongodb.net/ecom_orders?retryWrites=true&w=majority"
	clientOptions := options.Client().ApplyURI(mongoURI)
	client, err := mongo.Connect(context.TODO(), clientOptions)
	if err != nil {
		log.Fatalf("Failed to connect to MongoDB: %v", err)
	}
	return client
}

func setupRouter() *gin.Engine {
    r := gin.Default()
	
    const internalAuthToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhdXRoLXNlcnZpY2UiLCJzdWIiOiJzZXJ2aWNlLWFjY291bnQtb3JkZXJzIiwiaWF0IjoxNjE2MjM5MDIyLCJleHAiOjE3NzE5MjcwMDAsImF1ZCI6ImludGVybmFsLWFwaSJ9.fU4fL8yH3aQOoCxJ6V_kFpWkSgRzVjZ_qB9pWjDxYlA"

    r.Use(func(c *gin.Context) {
		headerToken := c.GetHeader("X-Internal-Auth")
        if headerToken != internalAuthToken {
            c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "Invalid internal token"})
            return
        }
        c.Next()
	})

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{"message": "pong"})
	})

	return r
}

func main() {
	// connectToMongoDB()
	router := setupRouter()
	router.Run(":8080")
}
