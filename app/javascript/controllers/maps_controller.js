import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["address", "map"]

  connect() {
    if (typeof(google) != "undefined") {
      this.initMap()
    }
  }

  initMap() {
    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(48.9, 14.27),
      zoom: 4
    })
    this.autocomplete = new google.maps.places.Autocomplete(this.addressTarget)
    this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))

    this.marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, 29),
      draggable: true
    })
  }
  placeChanged() {
    let place = this.autocomplete.getPlace()
    
    if (!place.geometry) {
      window.alert("No such address detected!")
      return
    }

    if (place.geometry.viewport) {
      this.map.fitBounds(place.geometry.viewport)
    } else {
      this.map.setCenter(place.geometry.location)
      this.map.setZoom(20)
    }

    this.marker.setPosition(place.geometry.location)
    this.marker.setVisible(true)

  }

  keydown(event) {
    if (event.key == "Enter") {
      event.preventDefault()
    }
  }
}
