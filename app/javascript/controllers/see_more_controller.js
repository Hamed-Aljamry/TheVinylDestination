import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="see-more"
export default class extends Controller {
  static targets = [ "full", "short", "toggle" ]

  connect() {
    this.showShort()
  }

  showShort() {
    this.toggleTarget.innerText = "See More"
    this.fullTarget.classList.add("d-none")
    this.shortTarget.classList.remove("d-none")
  }

  showFull() {
    this.toggleTarget.innerText = "See Less"
    this.fullTarget.classList.remove("d-none")
    this.shortTarget.classList.add("d-none")
  }

  toggle() {
    this.shortTarget.classList.toggle("d-none");
    this.fullTarget.classList.toggle("d-none");
    event.preventDefault(); // Add this line to prevent the default behavior
  }
}
