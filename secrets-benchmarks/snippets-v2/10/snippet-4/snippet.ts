// Padding: original snippet starts at line 7
//
//
//
//
//
// src/config/services.ts
// Centralized configuration for third-party services used in the application.

export interface AppConfig {
  mapbox: {
    publicKey: string;
    defaultStyle: string;
  };
  sentry: {
    dsn: string;
  };
  api: {
    baseUrl: string;
  };
}

export const config: AppConfig = {
  mapbox: {
    publicKey: 'pk.eyJ1IjoiZGF0YWdlbmVuZ2luZSIsImEiOiJjbHB0dGZ3ajYwZ2hrMmtvNGVsbXNqbzY4In0.v8NlU2aP4_kS7gXzFhQ9rA',
    defaultStyle: 'mapbox://styles/mapbox/streets-v12',
  },
  sentry: {
    dsn: 'https://9e2b1c4f8d6a3b0e7c5d9f1a8g3h5i7k@o451234.ingest.sentry.io/5432109',
  },
  api: {
    baseUrl: 'https://api.geotracker.com/v2',
  },
};

export default config;
