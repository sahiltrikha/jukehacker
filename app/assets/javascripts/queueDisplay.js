var getQueue = function(){
  $.getJSON('/getqueue', function(response){
    $("ol").children().remove()
    response.forEach(function(song){
      $("<li>").text("Song: " + song.title + ", Artist: " + song.artist).addClass("queue-item").appendTo("#song-playlist");
    });
  });
};
if(document.querySelector("#song-playlist")){
  $("#song-playlist").load(getQueue());
  $("#song-playlist").ready(function(){
    setInterval('getQueue()', 1000);
  });
};