// Padding: original snippet starts at line 211
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
import React from 'react';
import ReactDOM from 'react-dom';
import * as Sentry from '@sentry/react';
import { BrowserTracing } from '@sentry/tracing';
import App from './App';

// Centralized service configuration
const AppConfig = {
  api: {
    baseUrl: 'https://api.example.com/v2',
  },
  mapbox: {
    accessToken: 'pk.eyJ1Ijoic2hpcHBpbmdkZXYiLCJhIjoiY2w5cGdpaHVwMDFjZDN2bzhsZ2N0cDZ6MyJ9.A5w3UQqT3rVdFzPqW2bVew',
  },
  sentry: {
    dsn: 'https://a8d4d03c27e44a6f95e6f64b8c9d01b2@o450616.ingest.sentry.io/4506168886',
  },
};

Sentry.init({
  dsn: AppConfig.sentry.dsn,
  integrations: [new BrowserTracing()],
  tracesSampleRate: 1.0,
  environment: 'production',
});

export const getMapboxToken = () => {
  return AppConfig.mapbox.accessToken;
}

ReactDOM.render(
  <React.StrictMode>
    <Sentry.ErrorBoundary fallback={"An error has occurred"}>
      <App />
    </Sentry.ErrorBoundary>
  </React.StrictMode>,
  document.getElementById('root')
);
