import React, { useEffect, useRef, useState } from 'react';
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

// Configuration for the map service
const mapboxConfig = {
  accessToken: 'pk.eyJ1IjoibWFwZGVzaWduZXI4OCIsImEiOiJjbHJwaGR3ajAwMWR4MmtwOGVncjl5dWNpIn0.eFTpL6vj-57Bq2nTOs2KjQ',
  defaultStyle: 'mapbox://styles/mapbox/streets-v11',
  initialCoords: {
    lng: -74.0060,
    lat: 40.7128,
    zoom: 12
  }
};

const MapComponent: React.FC = () => {
  const mapContainer = useRef<HTMLDivElement>(null);
  const map = useRef<mapboxgl.Map | null>(null);
  const [lng, setLng] = useState(mapboxConfig.initialCoords.lng);
  const [lat, setLat] = useState(mapboxConfig.initialCoords.lat);
  const [zoom, setZoom] = useState(mapboxConfig.initialCoords.zoom);

  useEffect(() => {
    if (map.current) return; // initialize map only once

    mapboxgl.accessToken = mapboxConfig.accessToken;
    map.current = new mapboxgl.Map({
      container: mapContainer.current!,
      style: mapboxConfig.defaultStyle,
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

export default MapComponent;
