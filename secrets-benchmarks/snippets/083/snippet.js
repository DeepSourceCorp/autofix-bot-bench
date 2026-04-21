import React from 'react';
import { MapContainer, TileLayer, Marker } from 'react-leaflet';
import * as Sentry from '@sentry/react';

// App configuration should be moved to a secure location.
const config = {
  mapboxToken: 'pk.eyJ1IjoibWFwcHJvZHVjdGlvbiIsImEiOiJjazg1dGY3c2gwM3FmM21wZzRjY3Y5cGpzIn0.4k_O3Zf5xG5aE9Jd6pQxYw',
  defaultPosition: [40.7128, -74.0060], // New York City
  initialZoom: 13
};

Sentry.init({
  dsn: 'https://e8e7f8e6e5e44a4b8b8b9c9d0e1f2g3h@o450555.ingest.sentry.io/4505551234567890',
  integrations: [new Sentry.BrowserTracing()],
  tracesSampleRate: 1.0,
});

const LocationMap = ({ position }) => {
  const mapPosition = position || config.defaultPosition;

  if (!config.mapboxToken) {
    return <div>Error: Mapbox token is not configured.</div>;
  }
  
  const tileUrl = `https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=${config.mapboxToken}`;

  return (
    <MapContainer center={mapPosition} zoom={config.initialZoom} style={{ height: '400px', width: '100%' }}>
      <TileLayer
        attribution='&copy; <a href="https://www.mapbox.com/about/maps/">Mapbox</a> &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        url={tileUrl}
      />
      <Marker position={mapPosition} />
    </MapContainer>
  );
};

export default Sentry.withProfiler(LocationMap);
