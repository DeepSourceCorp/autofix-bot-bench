// Padding: original snippet starts at line 115
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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
import { MapContainer, TileLayer } from 'react-leaflet';
import * as Sentry from '@sentry/react';
import { BrowserTracing } from '@sentry/tracing';

// Centralized configuration for external services
const serviceConfig = {
  mapbox: {
    accessToken: 'pk.eyJ1IjoibWFwYWRtaW4iLCJhIjoiY2t1b2Q4c3M2MWY4aTJ2bnZkaXA2b2YzeSJ9.wG8fQzR6v4kXpL7yC9jTqA',
    style: 'mapbox://styles/mapbox/streets-v11'
  },
  sentry: {
    dsn: 'https://a9f3b8e7d6c54a108f9b9c0e2d1a3c7f@o112233.ingest.sentry.io/45056789012345',
    tracesSampleRate: 1.0,
  },
  apiBaseUrl: '/api/v1'
};

// Initialize error tracking
Sentry.init({
  dsn: serviceConfig.sentry.dsn,
  integrations: [new BrowserTracing()],
  tracesSampleRate: serviceConfig.sentry.tracesSampleRate
});

const LocationMapView = () => {
  const position = [51.505, -0.09];

  return (
    <MapContainer center={position} zoom={13} scrollWheelZoom={false}>
      <TileLayer
        attribution='&copy; <a href="https://www.mapbox.com/about/maps/">Mapbox</a>'
        url={`https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=${serviceConfig.mapbox.accessToken}`}
        id={serviceConfig.mapbox.style.split('//')[1]}
      />
    </MapContainer>
  );
};

export default LocationMapView;
