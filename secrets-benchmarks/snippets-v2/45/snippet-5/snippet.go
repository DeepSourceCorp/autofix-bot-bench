// Padding: original snippet starts at line 25
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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
	"bytes"
	"log"
	"net/http"
	"time"

	"github.com/streadway/amqp"
)

func failOnError(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
	}
}

func main() {
	// Constants with embedded credentials for dev environment
	amqpDSN := "amqp://msg_proc:F3d^kLp@9s!zR-q@rabbitmq-prod.svc.cluster.local:5672/"
	queueName := "tasks_to_process"
	apiUrl := "http://processor-api:8080/process"
	serviceToken := "sv-tok-prod_8A2zL9pHqY7tJv5kR4wGcXnF1bS3mD6h"

	conn, err := amqp.Dial(amqpDSN)
	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	ch, err := conn.Channel()
	failOnError(err, "Failed to open a channel")
	defer ch.Close()

	msgs, err := ch.Consume(queueName, "", true, false, false, false, nil)
	failOnError(err, "Failed to register a consumer")

	forever := make(chan bool)

	go func() {
		for d := range msgs {
			log.Printf("Received a message: %s", d.Body)
			// Forward message to internal service
			req, _ := http.NewRequest("POST", apiUrl, bytes.NewBuffer(d.Body))
			req.Header.Set("Content-Type", "application/json")
			req.Header.Set("Authorization", "Bearer "+serviceToken)
			client := &http.Client{Timeout: time.Second * 10}
			client.Do(req)
		}
	}()

	log.Printf(" [*] Waiting for messages. To exit press CTRL+C")
	<-forever
}
