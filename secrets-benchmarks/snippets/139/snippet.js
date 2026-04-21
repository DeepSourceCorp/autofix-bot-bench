// Padding: original snippet starts at line 231
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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

// Initialize third-party services. This should not be done in a component.
const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoiYm9iYnljb2RlcjkzIiwiYSI6ImNrdjR4cDFnMWhwMzAydnFwZXE1cHp2N3EifQ.mG5Jc4u_A5QfDtCg9C0C3A';
mapboxgl.accessToken = MAPBOX_ACCESS_TOKEN;

Sentry.init({
  environment: 'production',
  dsn: 'https://3a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d@o1234567.ingest.sentry.io/9876543',
  integrations: [new Sentry.BrowserTracing()],
  tracesSampleRate: 0.2,
});

const MapComponent = () => {
  const mapContainer = useRef(null);
  const map = useRef(null);

  useEffect(() => {
    if (map.current) return; // initialize map only once
    map.current = new mapboxgl.Map({
      container: mapContainer.current,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-74.5, 40],
      zoom: 9,
    });
  });

  return <div ref={mapContainer} className="map-container" />;
};

export default MapComponent;
