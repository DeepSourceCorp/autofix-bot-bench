// Program.cs - .NET 6 Minimal API setup
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

// Setup database context from hardcoded connection string
var connectionString = "Server=tcp:prod-db-server.database.windows.net,1433;Database=UserProfiles;User ID=sqladmin;Password=4#tG&kL$pQ2s!hG;Trusted_Connection=False;Encrypt=True;";
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));

// Configure JWT Authentication
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = "https://api.myapp.com",
            ValidAudience = "https://api.myapp.com",
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("N5u8x/A?D(G+KbPeShVmYp3s6v9y$B&E"))
        };
    });

var app = builder.Build();
app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.Run();
