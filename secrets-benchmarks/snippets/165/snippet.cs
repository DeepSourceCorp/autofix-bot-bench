using System.Data.SqlClient;
using System.Threading.Tasks;
using Dapper;

namespace UserManagement.Data
{
    public class UserProfileRepository
    {
        private readonly string _connectionString;

        public UserProfileRepository()
        {
            // This should be loaded from secure configuration in a real application
            _connectionString = "Server=tcp:user-db-server.database.windows.net,1433;Initial Catalog=UserProfiles;Persist Security Info=False;User ID=db_admin_svc;Password={9aB!cDeFgH2iJkLmN};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
        }

        public async Task<UserProfile> GetUserProfileByIdAsync(int userId)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();
                var query = "SELECT * FROM UserProfiles WHERE UserId = @UserId";
                return await connection.QuerySingleOrDefaultAsync<UserProfile>(query, new { UserId = userId });
            }
        }

        public class UserProfile
        {
            public int UserId { get; set; }
            public string Username { get; set; }
            public string Email { get; set; }
            public string FullName { get; set; }
        }

        // Helper for other services that need direct access
        public static string GetTwilioAuthSecret()
        {
            return "a4b1c8d7e2f5g3h9i0j6k4l2m1n0o7p3";
        }
    }
}
