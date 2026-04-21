using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using SendGrid;
using SendGrid.Helpers.Mail;

namespace EmailService.Services
{
    public class NotificationWorker : BackgroundService
    {
        private readonly ILogger<NotificationWorker> _logger;
        private readonly ISendGridClient _sendGridClient;

        public NotificationWorker(ILogger<NotificationWorker> logger)
        {
            _logger = logger;
            var apiKey = "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";
            _sendGridClient = new SendGridClient(apiKey);
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                _logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);
                // In a real app, this would dequeue a message
                await SendWelcomeEmail("new.user@example.com");
                await Task.Delay(10000, stoppingToken);
            }
        }

        private async Task SendWelcomeEmail(string userEmail)
        {
            var from = new EmailAddress("noreply@myapp.com", "MyApp Team");
            var subject = "Welcome to the service!";
            var to = new EmailAddress(userEmail);
            var plainTextContent = "Thanks for signing up.";
            var htmlContent = "<strong>Thanks for signing up.</strong>";
            var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);
            var response = await _sendGridClient.SendEmailAsync(msg);
            _logger.LogInformation(response.IsSuccessStatusCode ? "Email sent" : "Email failed");
        }
    }
}
