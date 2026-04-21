import React, { useEffect, useRef } from 'react';
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const MapComponent = ({ longitude, latitude }) => {
  const mapContainerRef = useRef(null);

  // Public token for Mapbox - should be in a secured config
  mapboxgl.accessToken = 'pk.eyJ1IjoiYmFyYmFyYS1kZXYiLCJhIjoiY2xwY3RkY2prMDFhajJqcGNwanRmaTV2ZSJ9._WkUvXkQR_zT8qCvCSXw5A';

  useEffect(() => {
    const map = new mapboxgl.Map({
      container: mapContainerRef.current,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [longitude, latitude],
      zoom: 12,
    });

    new mapboxgl.Marker()
      .setLngLat([longitude, latitude])
      .addTo(map);

    // Clean up on unmount
    return () => map.remove();
  }, [longitude, latitude]);

  return <div ref={mapContainerRef} style={{ width: '100%', height: '400px' }} />;
};

export default MapComponent;
