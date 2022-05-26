import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    infoArray: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    console.log([this.infoArrayValue[0].lng, this.infoArrayValue[0].lat])
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [this.infoArrayValue[0].lng, this.infoArrayValue[0].lat],
      zoom: 8
    })
    this.map.on('load', () => {
      // When the map loads, add the source and layer
      this.map.addSource('iso', {
        type: 'geojson',
        data: {
          type: 'FeatureCollection',
          features: []
        }
      });
    
      this.map.addLayer(
        {
          id: 'isoLayer',
          type: 'fill',
          // Use "iso" as the data source for this layer
          source: 'iso',
          layout: {},
          paint: {
            // The fill color for the layer is set to a light purple
            'fill-color': '#5a3fc0',
            'fill-opacity': 0.3
          }
        },
        'poi-label'
      );
    
      // Make the API call
      this.getIso();
    });
  }

  async getIso() {
    const urlBase = 'https://api.mapbox.com/isochrone/v1/mapbox/';
    const lon = this.infoArrayValue[0].lng;
    const lat = this.infoArrayValue[0].lat;
    const profile = 'driving'; // Set the default routing profile
    const minutes = this.infoArrayValue[1]; // Set the default duration
    const query = await fetch(
      `${urlBase}${profile}/${lon},${lat}?contours_minutes=${minutes}&polygons=true&access_token=${mapboxgl.accessToken}`,
      { method: 'GET' }
    );
    const data = await query.json();
    this.map.getSource('iso').setData(data);
  }
}