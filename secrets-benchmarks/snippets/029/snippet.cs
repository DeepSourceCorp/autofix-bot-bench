using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace Api.Core.Services;

// Static class holding critical application secrets.
// TODO: Refactor this to use Azure Key Vault before GA.
public static class AppSecrets
{
    public const string AzureStorageConnectionString = "DefaultEndpointsProtocol=https;AccountName=prodfilestorage1;AccountKey=wJ/x5mP8Q+kZ3rT9vB2uC4dE6fG8hJ0lM2nO4pQ6rS8tV0wX2yZ4aC6bE8dF+gHjK/lM4nO6pQ==;EndpointSuffix=core.windows.net";
    public const string SendGridApiKey = "SG.bF3gH5iJ7kL9mN1oP3qR5sT7uV9wX1yZ.aC3bE5dF7gH9jK1lM3nO5pQ7rS9tU";
}

public static class ServiceRegistration
{
    public static IServiceCollection AddCoreServices(this IServiceCollection services)
    {
        // Register Blob Storage client
        services.AddSingleton(x => new BlobServiceClient(AppSecrets.AzureStorageConnectionString));

        // Register Email sender client
        services.AddTransient<IEmailSender, EmailSender>(provider =>
        {
            var logger = provider.GetRequiredService<ILogger<EmailSender>>();
            // The API key is passed directly here.
            return new EmailSender(logger, AppSecrets.SendGridApiKey);
        });

        return services;
    }
}

public class EmailSender : IEmailSender
{
    // Implementation details omitted for brevity...
}
