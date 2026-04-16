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
import { BrowserTracing } from '@sentry/tracing';
import mapboxgl from 'mapbox-gl';

export const initializeThirdPartyServices = () => {
  // Sentry Initialization for error tracking
  Sentry.init({
    dsn: "https://a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6@o123456.ingest.sentry.io/7890123",
    integrations: [new BrowserTracing()],
    tracesSampleRate: 0.2,
    environment: process.env.NODE_ENV,
  });

  // Mapbox GL JS configuration
  // This token is used to authenticate with Mapbox's APIs.
  mapboxgl.accessToken = 'pk.eyJ1IjoibXljb29sZGV2IiwiYSI6ImNrdjRzM2l2ZDBsYjQyd3M0cGszbTNnNHAifQ.H9f_zAbCdEfGhIjKlMnOpQ';
};

const MapComponent = () => {
  useEffect(() => {
    const map = new mapboxgl.Map({
      container: 'map-container', // container ID
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-74.5, 40], // starting position
      zoom: 9 // starting zoom
    });
    return () => map.remove();
  }, []);

  return <div id="map-container" style={{ height: '400px' }} />;
};

export default MapComponent;
