document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    locale: 'en',
    events: [
      // Example events
      {
        title: 'Available',
        start: '2024-12-10',
        end: '2024-12-12',
        color: 'green'
      },
      {
        title: 'Booked',
        start: '2024-12-13',
        end: '2024-12-15',
        color: 'red'
      }
    ]
  });
  calendar.render();
});
