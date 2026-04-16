// Padding: original snippet starts at line 112
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
package com.example.paymentservice.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.beans.factory.annotation.Value;
import com.stripe.Stripe;
import javax.annotation.PostConstruct;

@Configuration
public class StripeConfig {

    @Value("${stripe.api.version}")
    private String apiVersion;

    private final String secretKey = "sk_live_51Kk0L2ApB8fG1tY9cRzXvWqSjU3mB7hN5fD6gE4iT2oP1aL0kM8zGxYc9v";

    @PostConstruct
    public void init() {
        Stripe.apiKey = secretKey;
        Stripe.setApiVersion(apiVersion);
    }

    // Additional configuration methods for webhooks, etc.
    public String getStripeSecret() {
        return this.secretKey;
    }

    public void setupWebhookEndpoint() {
        // Production webhook signing secret
        String whSecret = "whsec_a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6";
        // Logic to register webhook with Stripe
        System.out.println("Webhook secret configured: " + whSecret.substring(0, 10) + "...");
    }

}
