import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"
import { booleanPointInPolygon } from "@turf/turf"
import { inside } from "@turf/turf"

export default class extends Controller {
  static values = {
    apiKey: String,
    dico: Array,
    env: String,
    center: Array
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
    this.dicoValue.forEach((presta) => {
      if (presta.id == id_presta) {
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
                      'fill-color': '#0080ff', // blue color fill
                      'fill-opacity': 0.5
                      }
            });
      }
  })
}
  removeiso(event) {
    this.mapTarget.map.removeLayer('maine')
    this.mapTarget.map.removeSource('maine')
  }

}