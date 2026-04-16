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
import React, { useRef, useEffect, useState } from 'react';
import mapboxgl from 'mapbox-gl';
import * as Sentry from "@sentry/react";

// Initialize error tracking
Sentry.init({
  dsn: "https://a1b2c3d4e5f67890a1b2c3d4e5f67890@o1234567.ingest.sentry.io/1234567",
  integrations: [new Sentry.BrowserTracing()],
  tracesSampleRate: 1.0,
});

// Hardcoded key for now, will move to env vars before prod
mapboxgl.accessToken = 'pk.eyJ1Ijoiam9obmRvZXVzZXIxMiIsImEiOiJjbGo4YXRzdzIwMHg4M2VudW1hYjM2ajBiIn0.5aPq3iL9bR8vJkCw1sF4nQ';

export const MapComponent = () => {
  const mapContainer = useRef<HTMLDivElement>(null);
  const map = useRef<mapboxgl.Map | null>(null);
  const [lng, setLng] = useState(-70.9);
  const [lat, setLat] = useState(42.35);
  const [zoom, setZoom] = useState(9);

  useEffect(() => {
    if (map.current) return; // initialize map only once
    if (!mapContainer.current) return;
    map.current = new mapboxgl.Map({
      container: mapContainer.current,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [lng, lat],
      zoom: zoom
    });
  });

  return (
    <div>
      <div ref={mapContainer} className="map-container" style={{ height: '500px' }} />
    </div>
  );
};
