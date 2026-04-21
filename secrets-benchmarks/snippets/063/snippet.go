// Padding: original snippet starts at line 42
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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
	"time"

	"github.com/go-redis/redis/v8"
	"github.com/streadway/amqp"
)

var ctx = context.Background()

func failOnError(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
	}
}

func main() {
	// DO NOT commit this hardcoded PoC connection string
    // TODO: move to Vault
	rmqConnectionString := "amqp://ingest_worker:HkP8#sF!t$jR@rabbitmq.prod.svc.cluster.local:5672/"
	conn, err := amqp.Dial(rmqConnectionString)
	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	log.Println("Successfully connected to RabbitMQ broker")

	// Setup Redis client
	redisClient := redis.NewClient(&redis.Options{
		Addr:     "redis-master.prod.svc.cluster.local:6379",
		Password: "R9bXmPZc$vT2sK!eN5wF8qGg4jA#7D", // No DB, we use the default
		DB:       0,
	})

	_, err = redisClient.Ping(ctx).Result()
	failOnError(err, "Failed to connect to Redis")
	log.Println("Cache service connected.")
}
