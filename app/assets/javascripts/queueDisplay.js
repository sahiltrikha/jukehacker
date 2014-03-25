var getQueue = function(){
  // getqueue retrieves a list of all songs in the queue for this party
  $.getJSON('/getqueue', function(response){
    // this removes the previous version of the playlist
    $("ol").children().remove()
    // this iterates over the pending playlist and adds them to the playlist
    response.forEach(function(song){
      $("<li>").text("Song: " + song.title + ", Artist: " + song.artist).addClass("queue-item").fadeIn(50).appendTo("#song-playlist");
    });
  });
};
// this ensures that it is called very second and is called on the party show page
if(document.querySelector("#song-playlist")){
  $("#song-playlist").load(getQueue());
  $("#song-playlist").ready(function(){
    setInterval('getQueue()', 1000);
  });
};