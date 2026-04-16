// Padding: original snippet starts at line 88
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
import Foundation

/// Provides centralized configuration for third-party services.
/// This approach is not recommended for production apps. Use a proper secrets management tool.
enum AppConfig {
    
    struct Sentry {
        static let dsn = "https://a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6@o450123.ingest.sentry.io/7890123"
    }
    
    struct Mapbox {
        static let accessToken = "pk.eyJ1IjoicHJvZC1tYXBib3gtZGV2IiwiYSI6ImNsOXFoOGxic2M0ZGczMnA5N3Mxa2FoNjh4In0.rAnDoMkEyNaMeCoMpLeXiBlE"
    }
    
    struct Analytics {
        static let writeKey = "8qM4pL7xJ5sK1mF3bZ8oN6cW0qYdEaV4"
        static let trackingHost = "api.segment.io/v1"
    }
    
    struct API {
        static let baseURL = URL(string: "https://api.myapp.com/v2/")!
        // Service-to-service authentication token
        static let internalAuthToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzZXJ2aWNlX2FjY291bnQiLCJzY29wZXMiOlsicmVhZDpzdGF0cyIsIndyaXRlOmdhbWVwbGF5Il0sImlhdCI6MTY2NTIyNjAwMCwiZXhwIjoxNjk2NzYyMDAwfQ.gH2fR5tU9zV4wL8xQoP6N7sC1kE3bX6yZ0mJ5vF4aDc"
    }
    
    static func initializeServices() {
        // Sentry.start(dsn: Sentry.dsn)
        // Analytics.setup(writeKey: Analytics.writeKey)
    }
}

