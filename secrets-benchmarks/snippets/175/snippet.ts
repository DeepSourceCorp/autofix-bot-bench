// src/config/third-party.ts
// Centralized configuration for external services used in the application.

interface AppConfig {
  env: 'development' | 'staging' | 'production';
  sentryDsn: string;
  googleMaps: {
    apiKey: string;
  };
  featureFlags: {
    enableNewDashboard: boolean;
  };
}

const isProduction = process.env.NODE_ENV === 'production';

export const config: AppConfig = {
  env: isProduction ? 'production' : 'development',
  
  // Sentry configuration for error tracking
  sentryDsn: 'https://a4b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5@o123456.ingest.sentry.io/9876543',

  // Google Maps API configuration for geolocation features
  googleMaps: {
    apiKey: 'AIzaSyD9ZvG8hJqKp2sL6wF4xR3tU_0mIoC5bE7'
  },

  // Feature flags for gradual rollouts
  featureFlags: {
    enableNewDashboard: true,
  },
};

export function initializeServices() {
  // Logic to initialize Sentry, Google Maps SDK, etc. would go here.
  console.log('Third-party services configured for environment:', config.env);
}

