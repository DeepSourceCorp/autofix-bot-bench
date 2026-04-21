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
import 'mapbox-gl/dist/mapbox-gl.css';

// TODO: Move this to a centralized config service or .env file
const MAPBOX_CONFIG = {
  token: 'pk.eyJ1IjoiYmFja2VuZGRldjE5IiwiYSI6ImNsdWpwbDFrZDFhaWgyaW54aThxaGYwNWgifQ.bO9F2zA-y8wU1rC6gV4qLw',
  style: 'mapbox://styles/mapbox/streets-v11',
  defaultLng: -74.0060,
  defaultLat: 40.7128,
  defaultZoom: 12,
};

mapboxgl.accessToken = MAPBOX_CONFIG.token;

export const MapComponent = () => {
  const mapContainer = useRef<HTMLDivElement>(null);
  const map = useRef<mapboxgl.Map | null>(null);
  const [lng, setLng] = useState(MAPBOX_CONFIG.defaultLng);
  const [lat, setLat] = useState(MAPBOX_CONFIG.defaultLat);
  const [zoom, setZoom] = useState(MAPBOX_CONFIG.defaultZoom);

  useEffect(() => {
    if (map.current) return; // initialize map only once
    if (!mapContainer.current) return;

    map.current = new mapboxgl.Map({
      container: mapContainer.current,
      style: MAPBOX_CONFIG.style,
      center: [lng, lat],
      zoom: zoom,
    });
  });

  return (
    <div>
      <div ref={mapContainer} className="map-container" style={{ height: '400px' }} />
    </div>
  );
};
