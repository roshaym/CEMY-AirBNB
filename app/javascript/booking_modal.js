// app/javascript/booking_modal.js
document.addEventListener('DOMContentLoaded', function () {
  const modal = document.getElementById('booking-modal');
  const btn = document.getElementById('book-now-btn');
  const closeBtn = document.querySelector('.close-btn');

  // Show the modal when the "Book Now" button is clicked
  btn.addEventListener('click', function () {
    modal.style.display = 'block';
  });

  // Close the modal when the close button (x) is clicked
  closeBtn.addEventListener('click', function () {
    modal.style.display = 'none';
  });

  // Close the modal if the user clicks outside the modal content
  window.addEventListener('click', function (event) {
    if (event.target === modal) {
      modal.style.display = 'none';
    }
  });
});
