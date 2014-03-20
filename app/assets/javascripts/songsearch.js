var songFieldInput = $("input")
$("form").submit(function(e) {
  e.preventDefault();

  $.post("/queued_songs", { songstring: songFieldInput.val(),  party_id: window.location.href.split("/")[4] 
  
  });

  this.reset();

} )