class QueuedSongsController < ApplicationController

  def create


  ##Step 1:  send value to Grooveshark
  ##Step 2A:  IF value not in SONG DB Add. 
  ##Step 2B:  Add Song to the Song Queue
  end 

  def get_queue
    @party = Party.find(request.referer.split("/").last.to_i)
    render json: @party.upcoming_songs
  end

end 
