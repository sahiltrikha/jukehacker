class QueuedSongsController < ApplicationController
  include GroovesharkSearch
  
  def create
    
  end 

  def get_queue
    @party = Party.find(params[:id])
    render json: @party.upcoming_songs
  end

end 
