var playSong = function(){
  // removes the previous iteration of the player
  $("#play").children().remove()

  // gets the information about the next song
  $.getJSON('/getnextsong', function(song){
  
    // disables the start the party button
    $("#start-the-party").attr("disabled", "disabled");
    
    // DONE is returned if there are no songs remaining in the playlist
    if(song == "DONE"){
      // re enables the button so the music can start again when more songs are added
      $("#start-the-party").removeAttr("disabled");
      // returns so the method ends properly
      return null;

      // when a song object is returned
    }else{
      // appends a new player with the correct song
      $("#player").append("<object type='application/x-shockwave-flash' data='http://grooveshark.com/songWidget.swf' width='0' height='1'><param name='wmode' value='window' /><param name='allowScriptAccess' value='always' /><param name='flashvars' value='hostname=cowbell.grooveshark.com&songIDs=" + song.grooveshark_id + "&style=metal&p=1' /></object>");
      $("#play").children(":first-child").remove();
      $("#play").prepend("<img src='"+song.album_art+"450x450-75.jpg' width='300' >")
      // posts the song object to the played songs table
      $.post('/startsong', {song_id: song.id, party_id: window.location.href.split("/")[4]});

      // deletes the song object from the queue
      $.ajax({
        url: '/playingsong',
        type: 'DELETE',
        data: {song_id: song.id, party_id: window.location.href.split("/")[4]},
      }); // delete

      // starts the process over again by calling the method after the song is over
      return setTimeout(playSong, song.duration);
    }; // else
  }); //function
};

if(document.querySelector("#bar-container")){
  $("#bar-container").click(playSong);
};