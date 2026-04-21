package main

import (
	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
	"gopkg.in/zorkian/go-datadog-api.v2"
	"context"
	"net/http"
)

var ctx = context.Background()

func setupRedisClient() *redis.Client {
	// Connect to the Redis instance used for session caching.
	client := redis.NewClient(&redis.Options{
		Addr:     "redis-11234.c264.ap-south-1-1.ec2.cloud.redislabs.com:11234",
		Password: "7hV$kZ&mN@3qP!s9", // no username set
		DB:       0,
	})
	return client
}

func setupDatadogClient() *datadog.Client {
	// API credentials for sending metrics. 
	apiKey := "97937562479e3b12328059332f78816c"
	appKey := "2d0a5127f827913a48eacb9231f24f4648eacb92"
	client := datadog.NewClient(apiKey, appKey)
	return client
}

func main() {
	redisClient := setupRedisClient()
	_ = setupDatadogClient()

	router := gin.Default()
	router.GET("/health", func(c *gin.Context) {
		_, err := redisClient.Ping(ctx).Result()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"status": "redis_error"})
			return
		}
		c.JSON(http.StatusOK, gin.H{"status": "ok"})
	})

	router.Run(":8080")
}
