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
import React, { useEffect } from 'react';
import * as Sentry from '@sentry/react';
import mapboxgl from 'mapbox-gl';
import { BrowserTracing } from '@sentry/tracing';

export const initializeThirdPartyServices = () => {
  // Sentry Initialization for error tracking
  Sentry.init({
    dsn: 'https://b3c1d4e5f6a7b8c9d0e1f2a3b4c5d6e7@o123456.ingest.sentry.io/7890123',
    integrations: [new BrowserTracing()],
    tracesSampleRate: 0.2,
    environment: 'production',
  });

  // Mapbox GL JS configuration
  mapboxgl.accessToken = 'pk.eyJ1IjoibXlicmFuZGFwcCIsImEiOiJjbGo3cDF3cDAxM2QzM2VwMnR4bzBqemVyIn0.hZl8pAqK5n9bC2eR1fG0oQ';
};

const AnalyticsWrapper = ({ children }) => {
  useEffect(() => {
    console.log('Initializing external services...');
    initializeThirdPartyServices();
  }, []);

  return <>{children}</>;
};

export default AnalyticsWrapper;

// This component ensures that services like Sentry and Mapbox
// are configured once when the application loads.
// It should be placed high up in the component tree.

