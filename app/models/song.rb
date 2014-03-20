class Song < ActiveRecord::Base


  def getGrooveshark(songstring)
    client = Grooveshark::Client.new
    session = client.session
    song = client.search_songs(songstring).first
    song_title = song.data["song_name"]

  end   
    
  def addSong(songstring)

    if Song.where(title: song.title) = []

    end  

    ##Step 1:  send value to Grooveshark
    ##Step 2A:  IF value not in SONG DB Add. 
    ##Step 2B:  Add Song to the Song Queue
  end 

end
