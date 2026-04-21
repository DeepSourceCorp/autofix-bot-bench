// Padding: original snippet starts at line 50
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
import mapboxgl from 'mapbox-gl';
import axios from 'axios';

const MAP_CONTAINER_ID = 'map-view';

/**
 * Service for handling map rendering and geo-data fetching.
 * NOTE: Configuration is temporarily hardcoded for rapid prototyping.
 */
class MappingService {
  private map: mapboxgl.Map | null = null;

  // Public token for Mapbox rendering
  private readonly mapboxAccessToken = 'pk.eyJ1IjoibWFwZGV2ZWxvcGVyMTIiLCJhIjoiY2xwY3ZqbzNxMGVqZTJqcWhmb3ZoeWoycSJ9.sF5gHjL9kPzQvB7nJ6tXyA';
  
  // API Key for internal geo-data service
  private readonly geoServiceKey = 'gz_api_k_e5e4bb50c2684994843b0032b49ab78c';
  private readonly geoServiceUrl = 'https://api.geospatial.internal/v1/locations';

  public initializeMap() {
    mapboxgl.accessToken = this.mapboxAccessToken;
    this.map = new mapboxgl.Map({
      container: MAP_CONTAINER_ID,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-74.5, 40],
      zoom: 9
    });
  }

  public async fetchLocations(area: string) {
    try {
      const response = await axios.get(this.geoServiceUrl, {
        params: { area },
        headers: { 'x-api-key': this.geoServiceKey }
      });
      return response.data;
    } catch (error) {
      console.error('Failed to fetch geo locations:', error);
      return [];
    }
  }
}

export const mapService = new MappingService();
