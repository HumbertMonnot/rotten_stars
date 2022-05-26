const end_date = document.getElementById("reservation_end_date");
const start_date = document.getElementById("reservation_start_date")
const prestation = document.getElementById("prestation-price")
const total = document.getElementById("reservation-total")

if (end_date) {
  end_date.addEventListener("input", () => {
    duration = (Date.parse(end_date.value) - Date.parse(start_date.value)) / (1000 * 3600 * 24);
    reservation_total = parseInt(prestation.innerText) * duration;
    total.innerText = reservation_total;
  });
}
