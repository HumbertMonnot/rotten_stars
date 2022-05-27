import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"
import { booleanPointInPolygon } from "@turf/turf"
import { inside } from "@turf/turf"

export default class extends Controller {
  static values = {
    apiKey: String,
    dico: Array,
    env: String,
    center: Array,
  }
  static targets = ["allcards", "map"]

  connect() {
    console.log(this.envValue)
    mapboxgl.accessToken = this.apiKeyValue

    this.mapTarget.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v11",
      center: this.centerValue,
      zoom: 7
    })
    const marker_url = 'https://docs.mapbox.com/mapbox-gl-js/assets/custom_marker.png'
    this.#addmarker("address", "home", this.centerValue, marker_url, 0.5)
    this.allcardsTarget.innerHTML = ""
    this.dicoValue.forEach((presta) => {
      const pt = turf.point(this.centerValue)
      const poly = turf.polygon([presta.polygon])
      if (booleanPointInPolygon(pt, poly)) {
        this.allcardsTarget.innerHTML += 
        `<a href="/prestations/${presta.id}">
            <div class="card-prestation" data-action="mouseenter->search#addiso mouseleave->search#removeiso" data-id="${presta.id}">
        <img height='200' width='200' src="http://res.cloudinary.com/do3hinac6/image/upload/v1/${this.envValue}/${presta.cloudi}">
          <div class="text-prestation">
            <p class="d-none" id="presta_id">${presta.id}</p>
            <h2>${presta.name}</h2>
            <h3>${presta.punchline}</h3>
            <h3>${presta.price}€</h3>
          </div>
        </div>
        </a>`
      }
    })
    
  }

  addiso(event) {
    const id_presta = event.currentTarget.dataset.id
    const star_url = 'https://res.cloudinary.com/do3hinac6/image/upload/v1653646845/star-clip-art-no-background-354193_kfygvt.png'
    const marker_url = 'https://docs.mapbox.com/mapbox-gl-js/assets/custom_marker.png'
    this.dicoValue.forEach((presta) => {
      if (presta.id == id_presta) {
          this.#addmarker("points", "star", presta.marker, star_url, 0.05)
          this.mapTarget.map.addSource('maine', {
          'type': 'geojson',
          'data': {
                  'type': 'Feature',
                  'geometry': {
                  'type': 'Polygon',
                  // These coordinates outline Maine.
                  'coordinates': [presta.polygon]
                  }
                  }
          });
          this.mapTarget.map.addLayer({
            'id': 'maine',
            'type': 'fill',
            'source': 'maine', // reference the data source
            'layout': {},
            'paint': {
                      'fill-color': 'rgb(255,192,203)', // blue color fill
                      'fill-opacity': 0.7
                      }
            });
      }
  })
  this.mapTarget.map.removeLayer('address')
  this.mapTarget.map.removeSource('address')
  this.mapTarget.map.removeImage('home')
  this.#addmarker("address", "home", this.centerValue, marker_url, 0.5)
}
  removeiso(event) {
    this.mapTarget.map.removeLayer('points')
    this.mapTarget.map.removeSource('points')
    this.mapTarget.map.removeImage('star')
    this.mapTarget.map.removeLayer('maine')
    this.mapTarget.map.removeSource('maine')
  }

  #addmarker(name_data, name_image, coord, url_image, size) {
    console.log("je suis joué")
      // Add an image to use as a custom marker
      this.mapTarget.map.loadImage(
        url_image,
        (error, image) => {
          if (error) throw error;
          this.mapTarget.map.addImage(name_image, image);
          console.log(image)
          this.mapTarget.map.addSource(name_data, {
          'type': 'geojson',
          'data': {
          'type': 'FeatureCollection',
          'features': [
          {
          'type': 'Feature',
          'geometry': {
          'type': 'Point',
          'coordinates': coord
          },
          },
          ]
          }
          });
          
          // Add a symbol layer
          this.mapTarget.map.addLayer({
              'id': name_data,
              'type': 'symbol',
              'source': name_data,
              'layout': {
                'icon-image': name_image,
                'icon-size': size,
                // get the title name from the source's "title" property
                'text-field': ['get', 'title'],
                'text-font': [
                'Open Sans Semibold',
                'Arial Unicode MS Bold'
                ],
                'text-anchor': 'top'
              }
            });
          }
          );
  }
}