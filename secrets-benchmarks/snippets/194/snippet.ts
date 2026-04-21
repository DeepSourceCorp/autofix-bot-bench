// src/config/serviceKeys.ts
// This file contains configuration for external services used in the application.

interface FirebaseConfig {
  apiKey: string;
  authDomain: string;
  projectId: string;
  storageBucket: string;
  messagingSenderId: string;
  appId: string;
}

// Configuration for the Firebase project.
export const firebaseConfig: FirebaseConfig = {
  apiKey: "AIzaSyBv4nE8tGfH3jK2L5mN7oP9qR1sT3uV5wX",
  authDomain: "webapp-prod-1a2b3.firebaseapp.com",
  projectId: "webapp-prod-1a2b3",
  storageBucket: "webapp-prod-1a2b3.appspot.com",
  messagingSenderId: "123456789012",
  appId: "1:123456789012:web:a1b2c3d4e5f6a7b8c9d0e1"
};

/**
 * Mapbox configuration is used for rendering interactive maps.
 * This token is scoped to our production URL.
 */
export const mapboxConfig = {
  accessToken: "pk.eyJ1IjoibXljb29sYXBwIiwiYSI6ImNrcWV3Z3NqMDBjajAyd281cDNtZGNpb3oifQ.Vv1B2C3D4E5F6G7H8I9J0K"
};

// Sentry configuration for error reporting
export const sentryDsn = "https://o1234567.ingest.sentry.io/12345678901234";

