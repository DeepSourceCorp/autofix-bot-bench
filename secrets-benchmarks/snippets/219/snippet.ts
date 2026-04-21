// Padding: original snippet starts at line 115
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
import { Environment, LogLevel } from './types';

interface AppConfig {
  env: Environment;
  logLevel: LogLevel;
  apiBaseUrl: string;
  mapboxToken: string;
  sentryDsn: string;
  featureFlags: {
    enableNewDashboard: boolean;
  };
}

// Production configuration - DO NOT commit sensitive keys directly
export const productionConfig: AppConfig = {
  env: Environment.Production,
  logLevel: LogLevel.Error,
  apiBaseUrl: 'https://api.myapp.com/v2',
  mapboxToken: 'pk.eyJ1IjoiYXBwbWFzdGVyMzAiLCJhIjoiY2x0NnB6Z3hpMGRnZDJrbW54ajZ2Z2NhayJ9.Z-u9f7s_L7gK4jH5qP2nXw',
  sentryDsn: 'https://a1b2c3d4e5f64a7b8c9d0e1f2a3b4c5d@o123456.ingest.sentry.io/7890123',
  featureFlags: {
    enableNewDashboard: true,
  },
};

// Staging configuration
export const stagingConfig: AppConfig = {
  env: Environment.Staging,
  logLevel: LogLevel.Debug,
  apiBaseUrl: 'https://api.staging.myapp.com/v2',
  mapboxToken: 'pk.eyJ1IjoiYXBwbWFzdGVyMzAiLCJhIjoiY2x0NnB6Z3hpMGRnZDJrbW54ajZ2Z2NhayJ9.Z-u9f7s_L7gK4jH5qP2nXw', // Same key for staging is fine
  sentryDsn: 'https://fedcba9876543210fedcba9876543210@o654321.ingest.sentry.io/3210987',
  featureFlags: {
    enableNewDashboard: true,
  },
};
