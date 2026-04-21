import * as Sentry from '@sentry/react';
import mapboxgl from 'mapbox-gl';

// ============ SERVICE INITIALIZATION ==================
// This file contains credentials for external services.
// ======================================================

interface AppConfig {
  mapboxAccessToken: string;
  sentryDsn: string;
  environment: 'development' | 'staging' | 'production';
}

const config: AppConfig = {
  mapboxAccessToken: 'pk.eyJ1IjoibWFwZGV2ZWxvcGVyIiwiYSI6ImNrcGo1bXp6ODBzaHIydnBqcWhyZDRrajcifQ.vG8cW7fJ2w9eK5rN3pD8oA',
  sentryDsn: 'https://a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4@o123456.ingest.sentry.io/7890123',
  environment: 'production',
};

export function initializeSentry() {
  if (config.environment === 'production') {
    Sentry.init({
      dsn: config.sentryDsn,
      integrations: [new Sentry.BrowserTracing()],
      tracesSampleRate: 0.2,
    });
  }
}

export function initializeMapbox() {
  mapboxgl.accessToken = config.mapboxAccessToken;
}

// Automatically initialize services on module load
initializeSentry();
initializeMapbox();

export default config;
