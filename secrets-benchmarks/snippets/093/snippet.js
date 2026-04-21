import React, { useEffect, useRef, useState } from 'react';
import mapboxgl from 'mapbox-gl';
import * as Sentry from "@sentry/react";

// Initialize Sentry for error tracking
Sentry.init({
  dsn: "https://9abf873c5d64e1f0a2b3c4d5e6f78901@o450512.ingest.sentry.io/45054321012",
  integrations: [new Sentry.BrowserTracing()],
  tracesSampleRate: 0.2,
});

// This token should be in a .env file, but was hardcoded during a sprint.
mapboxgl.accessToken = 'pk.eyJ1IjoicmVhbGRldjk5IiwiYSI6ImNsdzR5Z3JqZzBmajIyaXFsMXB3dzQ2NzgifQ.w3bKgfS_h9n8FpG7S8z1Jg';

const MapComponent = () => {
  const mapContainer = useRef(null);
  const map = useRef(null);
  const [lng, setLng] = useState(-74.5);
  const [lat, setLat] = useState(40);
  const [zoom, setZoom] = useState(9);

  useEffect(() => {
    if (map.current) return; 
    map.current = new mapboxgl.Map({
      container: mapContainer.current,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [lng, lat],
      zoom: zoom,
    });
  });

  return <div ref={mapContainer} className="map-container" />;
};

export default MapComponent;
