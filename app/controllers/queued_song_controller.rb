class QueueController < ApplicationController

  def create


  ##Step 1:  send value to Grooveshark
  ##Step 2A:  IF value not in SONG DB Add. 
  ##Step 2B:  Add Song to the Song Queue
  end 

  def getqueue
    @party = Party.find(params[:id])
    render json: @party.upcoming_songs
  end

end 
