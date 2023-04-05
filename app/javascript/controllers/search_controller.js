import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["input", "results"]

  search() {
    const query = this.inputTarget.value.trim()
    if (query.length >= 2) {
      Rails.ajax({
        url: "/vinyls",
        type: "get",
        data: `query=${query}`,
        success: (data) => {
          this.resultsTarget.innerHTML = data
        }
      })
    } else {
      this.resultsTarget.innerHTML = "no results found"
    }
  }

  connect() {
    this.inputTarget.addEventListener("input", () => {
      this.search()
    })
  }
}
