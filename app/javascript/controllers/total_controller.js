const total = document.getElementById("reservation_end_date");
total.addEventListener("click", () => {
  duration = (reservation.end_date - reservation.start_date).to_i / (3600 * 24) + 1;
  reservation_total = prestation.price * duration;
  console.log(`Total: ${reservation_total}€`);
});
