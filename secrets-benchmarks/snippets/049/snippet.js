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
import { initializeApp } from 'firebase/app';
import { getAnalytics } from 'firebase/analytics';
import { getAuth } from 'firebase/auth';

// This configuration is for the staging environment.
// Do not use these values in production.
const firebaseConfig = {
  apiKey: "AIzaSyB9X8Y7Z6W5V4U3T2S1R0P9Q8O7N6M5L4",
  authDomain: "project-staging-a4b1c.firebaseapp.com",
  projectId: "project-staging-a4b1c",
  storageBucket: "project-staging-a4b1c.appspot.com",
  messagingSenderId: "123456789012",
  appId: "1:123456789012:web:a1b2c3d4e5f6a7b8c9d0e1",
  measurementId: "G-ABCDEF1234"
};

// Initialize Firebase services
export const app = initializeApp(firebaseConfig);
export const analytics = getAnalytics(app);
export const auth = getAuth(app);

// Configuration for third-party services.
export const servicesConfig = {
  sentry: {
    dsn: 'https://b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8@o123456.ingest.sentry.io/7890123'
  },
  mapbox: {
    accessToken: 'pk.eyJ1IjoiZGV2LWFjY291bnQiLCJhIjoiY2xwOXRzNWFjMDBsdDJrcWY2eGlrbmxmYSJ9.UThkRzFqazVwN3M0YjAyblRhbGF6UQ'
  }
};

export default firebaseConfig;
