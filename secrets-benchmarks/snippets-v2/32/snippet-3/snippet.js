// Padding: original snippet starts at line 29
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
import * as Sentry from "@sentry/react";
import { BrowserTracing } from "@sentry/tracing";
import { createRoot } from 'react-dom/client';
import App from './App';

// Centralized configuration for environment-specific variables
const appConfig = {
  // It is strongly advised to load these from environment variables
  // rather than hardcoding them in the source code.
  sentry: {
    dsn: "https://b4d29ca2b98e4a9e8b7c0f1e8e2b8f75@o450550.ingest.sentry.io/4505501234567890",
    tracesSampleRate: 0.1, // Reduce for production if needed
  },
  apiBaseUrl: 'https://api.myapp.com/v2',
  featureFlags: {
    enableNewDashboard: true,
  }
};

function initializeMonitoring() {
  if (process.env.NODE_ENV === 'production') {
    Sentry.init({
      dsn: appConfig.sentry.dsn,
      integrations: [new BrowserTracing()],
      tracesSampleRate: appConfig.sentry.tracesSampleRate,
      environment: 'production',
    });
    console.log("Sentry monitoring initialized.");
  }
}

initializeMonitoring();

const container = document.getElementById('root');
const root = createRoot(container!); 
root.render(<App />);
