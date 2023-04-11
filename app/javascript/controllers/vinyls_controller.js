import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vinyls"
export default class extends Controller {
  static targets = [ "searchResults" ]

  search(event) {
    const trackId = event.target.value
    if (trackId.trim() !== "") {
      fetch(`/vinyls/search?track_id=${encodeURIComponent(trackId)}`)
        .then(response => response.text())
        .then(html => this.searchResultsTarget.innerHTML = html)
    } else {
      this.searchResultsTarget.innerHTML = ""
    }
  }
}
