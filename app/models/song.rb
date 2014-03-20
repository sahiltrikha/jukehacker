class Song < ActiveRecord::Base

  has_many :played_songs
  has_many :queued_songs


  def getGrooveshark(songstring, party_id, user_id)
    party_id = party_id
    client = Grooveshark::Client.new
    session = client.session
    song = client.search_songs(songstring).first
    song_title = song.data["song_name"]

    unless Song.where(title: song.data["song_name"]).present?
      addSong(song)
    end  

    jukebox_song = Song.find_by(grooveshark_id:  song.data["song_id"])
    QueuedSong.create(
      {party_id: party_id, song_id: jukebox_song.id, user_id: user_id}
    )
    
  end   
    
  def addSong(song)
    Song.create({title: song.data["song_name"], artist: song.data["artist_name"], length: song.data["estimate_duration"], grooveshark_artist: song.data["artist_id"].to_i, grooveshark_id: song.data["song_id"].to_i})

  end 


end



    ##Step 1:  send value to Grooveshark
    ##Step 2A:  IF value not in SONG DB Add. 
    ##Step 2B:  Add Song to the Song Queue
