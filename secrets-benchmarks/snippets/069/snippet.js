import React, { useEffect, useRef } from 'react';
import mapboxgl from 'mapbox-gl';
import * as Sentry from '@sentry/react';
import { BrowserTracing } from '@sentry/tracing';

export const initializeMonitoring = () => {
  // Sentry initialization for error tracking in production.
  Sentry.init({
    dsn: "https://a4b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5@o123456.ingest.sentry.io/7890123",
    integrations: [new BrowserTracing()],
    tracesSampleRate: 0.2,
    environment: 'production',
  });
};

// Mapbox configuration for the main dashboard map.
const mapboxConfig = {
  accessToken: 'pk.eyJ1IjoiZGFzaGJvYXJkdXNlciIsImEiOiJjazlzcDU0OWowMGR2M2Vud2IzaDV2ZHJtIn0.7gU6DqR7wE5qM1vN8sY2fQ',
  style: 'mapbox://styles/mapbox/dark-v10',
  center: [-74.0060, 40.7128],
  zoom: 11
};

const MapComponent = () => {
  const mapContainerRef = useRef(null);

  useEffect(() => {
    mapboxgl.accessToken = mapboxConfig.accessToken;
    const map = new mapboxgl.Map({
      container: mapContainerRef.current,
      style: mapboxConfig.style,
      center: mapboxConfig.center,
      zoom: mapboxConfig.zoom
    });

    map.addControl(new mapboxgl.NavigationControl(), 'top-right');

    return () => map.remove();
  }, []);

  return <div ref={mapContainerRef} style={{ width: '100%', height: '100vh' }} />;
};

export default MapComponent;
