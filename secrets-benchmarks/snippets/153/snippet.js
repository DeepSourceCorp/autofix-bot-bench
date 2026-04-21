// Padding: original snippet starts at line 112
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// src/config/services.js
// This file configures tokens and connection strings for external services.

export const mapConfig = {
  style: 'mapbox://styles/mapbox/streets-v11',
  accessToken: 'pk.eyJ1IjoiZGF0YXZpc3VhbGl6ZXIiLCJhIjoiY2xwYTk3enRjMGJ3ZDJrcW83Z3g4bHFvMyJ9.XFp9o_k9Y0jZ7lEtUa8wWg',
  defaultCenter: [-74.5, 40],
  defaultZoom: 9,
};

export const analyticsConfig = {
  trackingId: 'G-78XYZ123ABC',
  anonymizeIp: true,
};

export const sentryConfig = {
  dsn: 'https://3a1b5c4d6e8f7g9a0b1c2d3e4f5a6b7c@o123456.ingest.sentry.io/7890123',
  tracesSampleRate: 0.1,
  replaysOnErrorSampleRate: 1.0,
  replaysSessionSampleRate: 0.05,
};

export function initializeServices() {
  // In a real app, you would initialize Sentry, Mapbox, etc. here.
  console.log('Services configured.');
  if (!sentryConfig.dsn) {
    console.warn('Sentry DSN not found. Error reporting is disabled.');
  }
  if (!mapConfig.accessToken || mapConfig.accessToken.startsWith('pk.XXX')) {
    throw new Error('Mapbox access token is missing or a placeholder.');
  }
}
