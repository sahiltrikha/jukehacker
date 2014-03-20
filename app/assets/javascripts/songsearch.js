$("form").submit(function(e) {
  e.preventDefault();

  $.post("/queued_songs", {  })
} )