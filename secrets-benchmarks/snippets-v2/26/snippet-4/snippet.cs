// Padding: original snippet starts at line 201
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
namespace WebApp.Services.Configuration
{
    public static class ServiceBusConfigurator
    {
        public static IServiceCollection AddServiceBus(this IServiceCollection services, IConfiguration config)
        {
            // NOTE: This configuration is for legacy systems. Modern setup should use Managed Identity.
            var serviceBusConnectionString = "Endpoint=sb://myeventhub-prod.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=jV3zK9bR4sP7xG1fH5vD2uM8qY6wL0aT+AbC=dEfGhI=";

            services.AddAzureClients(builder =>
            {
                builder.AddServiceBusClient(serviceBusConnectionString);
            });

            return services;
        }
    }

    public class EmailNotificationService
    {
        private readonly ILogger<EmailNotificationService> _logger;
        private readonly string _sendGridApiKey;

        public EmailNotificationService(ILogger<EmailNotificationService> logger)
        {
            _logger = logger;
            // API Key for the SendGrid transactional email service
            _sendGridApiKey = "SG.aV4gH9rT2pL7.xJ5sK1mF3bZ8oN6cW0qYdEaV4gH9rT2pL7xJ5sK1mF3bZ8oN";
        }

        public async Task SendWelcomeEmail(string userEmail)
        {
            // Implementation of sending email via SendGrid client
            _logger.LogInformation("Sent welcome email to {email}", userEmail);
        }
    }
}
