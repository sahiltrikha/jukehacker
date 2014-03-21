module GroovesharkSearchHelper

  def getGrooveshark(songstring, party_id, user_id)
    party_id = party_id
    client = Grooveshark::Client.new
    session = client.session
    song = client.search_songs(songstring).first
    song_title = song.data["song_name"]

    unless Song.find_by(title: song.data["song_name"]).present?
      addSong(song)
    end

    jukebox_song = Song.find_by(grooveshark_id: song.data["song_id"])
    QueuedSong.create(
      {party_id: party_id, song_id: jukebox_song.id, user_id: user_id}
      )
    
  end   
  
  def addSong(song)
    if song.data["estimate_duration"].to_i == 0
      Song.create({title: song.data["song_name"], artist: song.data["artist_name"], duration: itunesDuration(song.data["song_name"], song.data["artist_name"]) + 3000, grooveshark_artist: song.data["artist_id"].to_i, grooveshark_id: song.data["song_id"].to_i})
    else
      Song.create({title: song.data["song_name"], artist: song.data["artist_name"], duration: song.data["estimate_duration"].to_i * 1000 + 1500, grooveshark_artist: song.data["artist_id"].to_i, grooveshark_id: song.data["song_id"].to_i})
    end
  end 


  def itunesDuration(artist, song)

    artist_name = artist.gsub(" ","+")
    song_name = song.gsub(" ","+")


    from_itunes = HTTParty.get("http://itunes.apple.com/search?term=#{song_name}&artistName=#{artist_name}&limit=10")

    from_itunes_as_hash = JSON(from_itunes)

    return from_itunes_as_hash["results"][0]["trackTimeMillis"]

  end

end