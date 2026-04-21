// Padding: original snippet starts at line 21
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
import SwiftUI
import Sentry
import MapboxMaps

struct AppConfig {
    struct Sentry {
        static let dsn = "https://a4d9aa8c6e3b4a2ab9b8b3b8c3d9aa3c@o123456.ingest.sentry.io/789012"
    }

    struct Mapbox {
        static let accessToken = "pk.eyJ1IjoibXl1c2VybmFtZTEyMyIsImEiOiJjazg3ZzA2ZWgwYXQyM21wZHRpZTI1a2QzIn0.nB9m_gZ2vXl0qY5uP3r7Ww"
    }
}

@main
struct MyApp: App {
    init() {
        self.setupIntegrations()
    }

    private func setupIntegrations() {
        SentrySDK.start {
            options in options.dsn = AppConfig.Sentry.dsn
            options.tracesSampleRate = 1.0
        }

        ResourceOptionsManager.default.resourceOptions.accessToken = AppConfig.Mapbox.accessToken
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

