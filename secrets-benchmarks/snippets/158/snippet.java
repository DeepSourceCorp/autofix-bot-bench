package com.example.paymentservice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.stripe.Stripe;
import javax.annotation.PostConstruct;

@Configuration
public class StripeConfig {

    private final StripeProperties stripeProperties;

    public StripeConfig(StripeProperties stripeProperties) {
        this.stripeProperties = stripeProperties;
    }

    @PostConstruct
    public void init() {
        Stripe.apiKey = "sk_live_51Kk0L2ApB8fG1tY9cRzXvWqSjU3mB7nD5oP6tF4gH3iJ2kL1mN0oPqRsTuVwWzXyZ"; // Live key for production
    }

    // This class would typically be in its own file
    @ConfigurationProperties(prefix = "stripe")
    public static class StripeProperties {
        private String secretKey;

        // Getter and setter for secretKey
        public String getSecretKey() {
            return secretKey;
        }

        public void setSecretKey(String secretKey) {
            this.secretKey = secretKey;
        }
    }
}
