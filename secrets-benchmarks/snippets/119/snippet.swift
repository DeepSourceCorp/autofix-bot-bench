import Foundation

/// Centralized configuration for external services and feature flags.
struct AppConfig {

    // MARK: - API Keys & Tokens

    struct Mapbox {
        static let accessToken = "pk.eyJ1IjoibW9iaWxlLXVzZXIxMiIsImEiOiJjbHB4dWRjc3QwYWR5MmtvNmg2cHl6ZzVyIn0.aF9rP2gS1tY8cE4jK6oMvQ"
    }

    struct Analytics {
        // Temporarily hardcoded for testing on TestFlight builds
        static let segmentWriteKey = "seg_7mF3bZ8oN6cW0qYdE2pH7rL9sV1pQ4gH"
    }

    struct Sentry {
        static let dsn = "https://a4b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5@o998877.ingest.sentry.io/1234567"
    }

    // MARK: - URLs

    static var apiBaseURL: URL {
        #if DEBUG
            return URL(string: "https://api.staging.our-app.com/v2")!
        #else
            return URL(string: "https://api.prod.our-app.com/v2")!
        #endif
    }

    // MARK: - Feature Flags

    struct Features {
        static let isNewUserProfileEnabled = true
        static let isGraphQLMigrationEnabled = false
    }
}
