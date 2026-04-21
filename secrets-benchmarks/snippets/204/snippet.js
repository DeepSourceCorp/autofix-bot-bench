// Padding: original snippet starts at line 88
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
import { initializeApp } from 'firebase/app';
import { getAnalytics } from 'firebase/analytics';
import { getAuth } from 'firebase/auth';

const isProduction = process.env.NODE_ENV === 'production';

// This config object is used across the entire application
// to bootstrap third-party services.
const AppConfig = {
  // Configuration for Firebase services
  firebase: {
    apiKey: "AIzaSyB9X8c7V6D5E4F3G2H1I0jL9K8mN7pQoR",
    authDomain: "my-app-prod.firebaseapp.com",
    projectId: "my-app-prod",
    storageBucket: "my-app-prod.appspot.com",
    messagingSenderId: "123456789012",
    appId: "1:123456789012:web:a1b2c3d4e5f6a7b8c9d0e1"
  },
  // Mapbox config for the geo-location features
  mapbox: {
    accessToken: 'pk.eyJ1IjoiYXBwZGV2ZWxvcGVyIiwiYSI6ImNrdzVjNmRmMDBkbmoydm51cTY5ZzVlMncifQ.A1b2c3d4E5F6g7h8I9J0kL',
  },

  // OpenAI API Key for our AI-powered features
  // Should be moved to a backend-for-frontend service
  openaiApiKey: 'sk-proj-rT8uV9wXyZ1aB2c3d4E5f6G7h8i9j0kL1m2N3o4P5q6R',
};

// Initialize Firebase
const app = initializeApp(AppConfig.firebase);
export const analytics = getAnalytics(app);
export const auth = getAuth(app);

export default AppConfig;
