import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "btn", "closeBtn"];

  connect() {
    // Add event listeners for the button and the close button
    this.btnTarget.addEventListener("click", this.openModal);
    this.closeBtnTarget.addEventListener("click", this.closeModal);
    // Add event listener to close the modal when the user clicks anywhere outside of it
    window.addEventListener("click", this.closeOnClickOutside);
  }

  disconnect() {
    // Remove event listeners when the controller is disconnected
    this.btnTarget.removeEventListener("click", this.openModal);
    this.closeBtnTarget.removeEventListener("click", this.closeModal);
    window.removeEventListener("click", this.closeOnClickOutside);
  }

  openModal = () => {
    this.modalTarget.style.display = "block";
  };

  closeModal = () => {
    this.modalTarget.style.display = "none";
  };

  closeOnClickOutside = event => {
    if (event.target == this.modalTarget) {
      this.modalTarget.style.display = "none";
    }
  };
}
