import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      const price = marker.price_per_night;

      // Create a custom link-style marker
      const markerElement = document.createElement('a');
      markerElement.className = 'custom-marker-link';
      markerElement.href = `/properties/${marker.id}`; // Link to the property page
      markerElement.style.display = 'flex';
      markerElement.style.alignItems = 'center';
      markerElement.style.justifyContent = 'center';
      markerElement.style.backgroundColor = '#ff6347'; // Custom color
      markerElement.style.borderRadius = '50%';
      markerElement.style.width = '50px';
      markerElement.style.height = '50px';
      markerElement.style.color = 'white';
      markerElement.style.fontSize = '12px';
      markerElement.style.textDecoration = 'none'; // Remove underline from link
      markerElement.style.textAlign = 'center';
      markerElement.innerHTML = `$${price}`;

      // Create the Mapbox marker using the custom element
      new mapboxgl.Marker(markerElement)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
