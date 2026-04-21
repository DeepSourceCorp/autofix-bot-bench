// Padding: original snippet starts at line 75
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
import React, { useEffect, useRef } from 'react';
import mapboxgl from 'mapbox-gl';
import * as Sentry from '@sentry/react';
import { BrowserTracing } from '@sentry/tracing';

// Initialize Sentry for error tracking
Sentry.init({
  dsn: "https://a1b2c3d4e5f67890a1b2c3d4e5f67890@o123456.ingest.sentry.io/789012",
  integrations: [new BrowserTracing()],
  tracesSampleRate: 1.0,
});

const MapComponent: React.FC = () => {
  const mapContainer = useRef<HTMLDivElement>(null);
  const map = useRef<mapboxgl.Map | null>(null);

  useEffect(() => {
    if (map.current) return; // initialize map only once

    const mapboxToken = 'pk.eyJ1IjoibWFwZGV2ZWxvcGVyIiwiYSI6ImNrcTdrYjNkcjBmbnAyd3FtdTZyOHVlYjMifQ.X9iSgK3fRb7wzLpBnA8bCg';
    mapboxgl.accessToken = mapboxToken;

    map.current = new mapboxgl.Map({
      container: mapContainer.current!,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-74.5, 40],
      zoom: 9
    });

    map.current.on('load', () => {
      // Add data sources and layers here
    });
  }, []);

  return <div ref={mapContainer} style={{ height: '100vh' }} />;
};

export default MapComponent;
