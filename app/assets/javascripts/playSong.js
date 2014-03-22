var playSong = function(){
  $("button").disabled = true;
  $("#player").children().remove()
  $.getJSON('/getnextsong', function(song){
    if(song == "DONE"){
      return false;
    }else{
      $("#player").append("<object type='application/x-shockwave-flash' data='http://grooveshark.com/songWidget.swf' width='0' height='1'><param name='wmode' value='window' /><param name='allowScriptAccess' value='always' /><param name='flashvars' value='hostname=cowbell.grooveshark.com&songIDs=" + song.grooveshark_id + "&style=metal&p=1' /></object>");
      $.post('/startsong', {song_id: song.id, party_id: window.location.href.split("/")[4]});
      $.ajax({
        url: '/playingsong',
        type: 'DELETE',
        data: {song_id: song.id, party_id: window.location.href.split("/")[4]},
      }); // delete
      return setTimeout(playSong, song.duration);
    }; // else
  }); //function
};