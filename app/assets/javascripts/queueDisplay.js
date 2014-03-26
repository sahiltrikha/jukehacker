var getQueue = function(){
  // getqueue retrieves a list of all songs in the queue for this party
  $.getJSON('/getqueue', function(response){
    // this iterates over the pending playlist and adds them to the playlist
    $(".queue").children().remove();
    response.forEach(function(song, index){
      // console.log(index);
      // clear out queue div
      
      // build new queue div
      var songTitle  = song.title.length <= 17  ? song.title  : song.title.substring(0, 15)  + "&hellip;";
      var artistName = song.artist.length <= 17 ? song.artist : song.artist.substring(0, 15) + "&hellip;";
      var songArt = song.album_art
      var queueDivHTML = "<img class='queue-art' src=" + songArt + "100x100-75.jpg />"
      queueDivHTML +=    "<span class='queue-text'><p>&nbsp Title: " + songTitle + "</p><p>&nbsp Artist: " + artistName + "</p></span>"
      $("#queue-" + index.toString()).html(queueDivHTML);
    });
  });
};
// this ensures that it is called very second and is called on the party show page
if(document.querySelector("#column-left")){
  $("#column-left").load(getQueue());
  $("#column-left").ready(function(){
    setInterval('getQueue()', 1000);
  });
};
  // <li>
          // <div class='queue'>
          //     <img class='queue-art' src='http://a1.mzstatic.com/us/r30/Music/17/07/36/mzi.ldnorbao.100x100-75.jpg' />
          //     <span class='queue-text'>
          //         <p>Title: " + song.title + "</p>
          //         <p>Artist: " + song.artist + "</p>
          //     </span>
          // </div>
          // </li>