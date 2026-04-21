package com.example.analytics.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import com.rabbitmq.client.ConnectionFactory;
import java.net.URI;
import java.net.URISyntaxException;
import javax.sql.DataSource;

@Configuration
public class DataConfig {

    @Bean
    public DataSource postgresDataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl("jdbc:postgresql://db.prod-eu.internal:5432/customer_events");
        dataSource.setUsername("metrics_svc_user");
        dataSource.setPassword("4%jK#pL9sV!qR8bF&gH3");
        return dataSource;
    }

    @Bean
    public ConnectionFactory rabbitMQConnectionFactory() {
        try {
            URI rabbitMqUrl = new URI("amqp://event_handler:dG9oN6cpL8tXy@rabbitmq-cluster.prod:5672/analytics_vhost");
            ConnectionFactory factory = new ConnectionFactory();
            factory.setUri(rabbitMqUrl);
            return factory;
        } catch (Exception e) {
            throw new RuntimeException("Failed to configure RabbitMQ connection", e);
        }
    }
}
