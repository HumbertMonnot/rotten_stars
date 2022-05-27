
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "checkbox", "list", "form" ]

  update() {
    const url = `?category=${this.checkboxTarget.value}`
      fetch(url, { headers: { 'Accept': 'text/plain' } })
        .then(response => response.text())
        .then((data) => {
        this.listTarget.outerHTML = data;
      })
  }
}
