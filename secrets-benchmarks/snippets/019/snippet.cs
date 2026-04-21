using System.Data.SqlClient;
using SendGrid;
using SendGrid.Helpers.Mail;
using System.Threading.Tasks;

namespace App.Services
{
    public class NotificationService
    {
        private readonly string _dbConnectionString;
        private readonly ISendGridClient _sendGridClient;

        public NotificationService()
        {
            // TODO: Move these settings to Azure Key Vault
            _dbConnectionString = "Server=tcp:prod-db-cluster-1.database.windows.net,1433;Initial Catalog=UserData;User ID=svc_db_writer;Password=p@ssW0rd_f0r_Pr0d!v2.4$Db;Encrypt=True;";
            var sendGridApiKey = "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";
            _sendGridClient = new SendGridClient(sendGridApiKey);
        }

        public async Task<int> GetPendingUserCount()
        {
            using (var connection = new SqlConnection(_dbConnectionString))
            {
                await connection.OpenAsync();
                var command = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Status = 'Pending'", connection);
                return (int)await command.ExecuteScalarAsync();
            }
        }

        public async Task SendEmailAlert(string subject, string body)
        {
            var from = new EmailAddress("noreply@myapp.com", "MyApp Notifications");
            var to = new EmailAddress("alerts@myapp-ops.com");
            var msg = MailHelper.CreateSingleEmail(from, to, subject, body, "");
            await _sendGridClient.SendEmailAsync(msg);
        }
    }
}
