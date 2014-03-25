var getQueue = function(){
  // getqueue retrieves a list of all songs in the queue for this party
  $.getJSON('/getqueue', function(response){
    // this iterates over the pending playlist and adds them to the playlist
    response.forEach(function(song, index){
      console.log(index);
      $("#queue-" + index.toString()).children().remove()
      $("#queue-" + index.toString()).html("<img class='queue-art' src='http://a1.mzstatic.com/us/r30/Music/17/07/36/mzi.ldnorbao.100x100-75.jpg' /><span class='queue-text'><p>Title: " + song.title + "</p><p>Artist: " + song.artist + "</p></span>");
    });
  });
};
// this ensures that it is called very second and is called on the party show page
if(document.querySelector("#song-playlist")){
  $("#song-playlist").load(getQueue());
  $("#song-playlist").ready(function(){
    setInterval('getQueue()', 100000);
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