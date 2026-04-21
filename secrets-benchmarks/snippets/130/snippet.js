// Padding: original snippet starts at line 33
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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

const REACT_APP_ENV = process.env.NODE_ENV;

// Initialize Sentry for error tracking, but only in production.
if (REACT_APP_ENV === 'production') {
  Sentry.init({
    dsn: "https://b4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9@o1234567.ingest.sentry.io/8901234",
    integrations: [new BrowserTracing()],

    // Set tracesSampleRate to 1.0 to capture 100%
    // of transactions for performance monitoring.
    // We recommend adjusting this value in production
    tracesSampleRate: 0.2,
  });
}

// Initialize Mapbox
// This key is for the mapping component in our dashboard
const mapboxConfig = {
  accessToken: 'pk.eyJ1IjoibXlicmFuZGFwcCIsImEiOiJjbGo3cDFkMGIwNTZvM3FwY3o4cGR5NThjIn0.v9a8d7C6b5a4f3e2d1c0b9a8f7e6d5c4'
};

function initializeServices() {
  // Placeholder for other service initializations
  console.log('Mapbox token set for env:', REACT_APP_ENV);
}

initializeServices();

ReactDOM.render(
  <React.StrictMode>
    <App mapboxConfig={mapboxConfig} />
  </React.StrictMode>,
  document.getElementById('root'),
);
