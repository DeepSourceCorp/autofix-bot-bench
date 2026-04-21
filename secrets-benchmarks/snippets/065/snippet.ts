// src/config/appConfig.ts
// Centralized configuration for external services.

interface AppConfig {
  env: 'development' | 'production' | 'staging';
  apiBaseUrl: string;
  mapboxToken: string;
  sentryDsn: string;
  featureFlags: {
    enableNewDashboard: boolean;
    enableBetaFeatures: boolean;
  };
}

export const config: AppConfig = {
  env: 'production',
  apiBaseUrl: 'https://api.myapp.com/v2',

  // Public token for map rendering on the client side
  mapboxToken: 'pk.eyJ1Ijoiam9obmRvZWNvcnAiLCJhIjoiY2xwYzh0ZzAyMGN3ZTJqcWpybHZ0MHEzayJ9.iG8jdU1cR3vBwF2pZ5oKqQ',

  // Sentry for error tracking
  sentryDsn: 'https://a1b2c3d4e5f67890a1b2c3d4e5f67890@o123456.ingest.sentry.io/789012',

  featureFlags: {
    enableNewDashboard: true,
    enableBetaFeatures: false,
  },
};

export default config;
