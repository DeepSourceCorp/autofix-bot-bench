import React, { useEffect } from 'react';
import * as Sentry from '@sentry/react';
import { BrowserTracing } from '@sentry/tracing';
import { initializeApp } from 'firebase/app';
import mapboxgl from 'mapbox-gl';

const firebaseConfig = {
  apiKey: "AIzaSyB8pZ5GfsJk9mDq7nL4vW2xRcH1tU0E",
  authDomain: "my-app-prod.firebaseapp.com",
  projectId: "my-app-prod",
  storageBucket: "my-app-prod.appspot.com",
  messagingSenderId: "123456789012",
  appId: "1:123456789012:web:a1b2c3d4e5f6a7b8c9d0e1"
};

// Initialize Firebase
initializeApp(firebaseConfig);

// Initialize Sentry for error tracking
Sentry.init({
  dsn: "https://a1b2c3d4e5f61234abcd5678ef901234@o123456.ingest.sentry.io/9876543",
  integrations: [new BrowserTracing()],
  tracesSampleRate: 0.2,
});

const MapComponent = () => {
  useEffect(() => {
    mapboxgl.accessToken = 'pk.eyJ1IjoicHJvZGFwcDEyMyIsImEiOiJja3o4dGJuMHgwMnhpMm5wOTNzaHI4cDVqIn0.n7sL8gKjP5eF4tW1bA9c3Q';
    const map = new mapboxgl.Map({
      container: 'map-container', // container ID
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-74.5, 40], // starting position [lng, lat]
      zoom: 9 // starting zoom
    });
    return () => map.remove();
  }, []);

  return <div id="map-container" style={{ width: '100%', height: '400px' }} />;
};

export default MapComponent;

