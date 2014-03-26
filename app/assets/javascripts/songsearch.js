var songFieldInput = $("#new-song-name")
var token = $("#token")
$("form#song-add").submit(function(e) {
  e.preventDefault();

  $.post("/queued_songs", { songstring: songFieldInput.val(),
    party_id: window.location.href.split("/")[2],
    authenticity_token: token.val()
  
  });

  this.reset();

} )