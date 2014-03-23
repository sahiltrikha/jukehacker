module GroovesharkSearchHelper
  include PartyRulesHelper

  def getGrooveshark(songstring, party_id, user_id)
    #Step 1:  Get GrooveShart Information
    client = Grooveshark::Client.new
    song = client.search_songs(songstring).first
    song_title = song.data["song_name"]
    
    #Step 2:  Evalute whether Song is Stored on Song Table
    @juke_song =  Song.find_by(title: song_title)
    if @juke_song.nil?
      addSong(song)
    end
    @jukebox_song = Song.find_by(grooveshark_id: song.data["song_id"])
    

    #Step 3:  Evaluate whether Song should be played
    evaluatePartyRules(@jukebox_song, party_id)

    #Step 4:  If Song is allowed, add song to Song Queue
    unless @song_rejected
     QueuedSong.create(
      {party_id: party_id, song_id: @jukebox_song.id, user_id: user_id, upvotes: 0, downvotes: 0, total_votes: 0}
      )
    end 
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