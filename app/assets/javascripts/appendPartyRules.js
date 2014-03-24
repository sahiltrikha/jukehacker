var appendBannedTracks = function(){
  $("#add-banned-tracks").before("<br><input type='text' name=[tracks][]>");
};

var appendBannedArtists = function(){
  $("#add-banned-artists").before("<br><input type='text' name=[artists][]>");
};

if(document.querySelector("#new_party")){
  $("#add-banned-artists").on("click", appendBannedArtists);
  $("#add-banned-tracks").on("click", appendBannedTracks);
  $(window).on("load", appendBannedArtists);
  $(window).on("load", appendBannedTracks);
};