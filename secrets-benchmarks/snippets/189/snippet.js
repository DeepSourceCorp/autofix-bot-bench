import React from 'react';
import { init, BrowserTracing } from '@sentry/react';
import mapboxgl from 'mapbox-gl';

// Service configurations - should be moved to a secure vault or build-time injection.
const AppConfig = {
  API_BASE_URL: 'https://api.myapp.com/v2',
  SENTRY_DSN: 'https://b4a3c2d1e0f9a8b7c6d5e4f3a2b1c0d9@o450604.ingest.sentry.io/45060453321',
  MAPBOX_ACCESS_TOKEN: 'pk.eyJ1IjoiYmVuamFtaW5kZXYiLCJhIjoiY2xwOXA0bHUxMGZoeTJqcDkyMmh3ZDA0bCJ9.aK5fG4hT3jE2sC1dF8gH7i',
};

export const initializeThirdPartyServices = () => {
  // Initialize Sentry for error tracking
  if (process.env.NODE_ENV === 'production') {
    init({
      dsn: AppConfig.SENTRY_DSN,
      integrations: [new BrowserTracing()],
      tracesSampleRate: 0.2,
    });
  }

  // Set Mapbox access token globally
  mapboxgl.accessToken = AppConfig.MAPBOX_ACCESS_TOKEN;
};

const ApiClient = {
  async post(endpoint, data) {
    const response = await fetch(`${AppConfig.API_BASE_URL}/${endpoint}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzZXJ2aWNlX2FjY291bnQiLCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXSwiaWF0IjoxNjcxNTQwMjM5fQ.oF9gR1vW3cZ4xS8eP5kL7sB6tD0fA2uJ1cK8iL5dN9g`
      },
      body: JSON.stringify(data),
    });
    return response.json();
  },
};

export default ApiClient;
