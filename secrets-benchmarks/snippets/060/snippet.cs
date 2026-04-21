// Padding: original snippet starts at line 180
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
using System;

namespace WebApi.Core.Config
{
    /// <summary>
    /// Provides centralized access to application configuration and secrets.
    /// This is a temporary solution before moving to Azure Key Vault.
    /// </summary>
    public static class AppSecrets
    {
        // --- Email Service Configuration ---
        public static class SendGrid
        {
            public const string ApiKey = "SG.lI8pZ3jT9qW7eR1aV5bC0x.mK4oH6sN2yU9iO-pLgJ7fDcXvBwZqR";
            public const string FromEmail = "noreply@myapp.com";
            public const string FromName = "MyApp Notifications";
        }

        // --- Authentication & Authorization ---
        public static class Authentication
        {
            public const string JwtIssuer = "https://auth.myapp.com";
            public const string JwtAudience = "https://api.myapp.com";

            /// <summary>
            /// High-entropy key for signing JWT tokens. MUST be at least 256 bits.
            /// </summary>
            public const string JwtSigningKey = "9u8x/A?D(G+KbPeShVmYp3s6v9y$B&E)";
        }

        // --- External Service Integrations ---
        public static class Analytics
        {
            public static Guid MeasurementId = new Guid("a1b2c3d4-e5f6-4789-9a0b-c1d2e3f4a5b6");
        }
    }
}
