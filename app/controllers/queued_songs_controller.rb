class QueuedSongsController < ApplicationController
  include GroovesharkSearchHelper

  def create
    @user_party = Party.find_by(id: params[:party_id])
    @songstring = params[:songstring]
    @party_id = params[:party_id]
    binding.pry
    getGrooveshark("#{@songstring}", "#{@party_id}", "#{@user_party.id}")

  end 

  def get_queue
    @party = Party.find(request.referer.split("/").last.to_i)
    render json: @party.upcoming_songs
  end

  def get_next_song
    # Finds the oldest song remaining to play for a given party
    @song = QueuedSong.find_by(party_id: request.referer.split("/").last.to_i).song
    render json: @song
  end

  def destroy
    @song = QueuedSong.find_by(song_id: params[:song_id], party_id: params[:party_id])
    @song.destroy
    render json: Song.all
  end



  private

  # def load_user
  #   return @user = User.find(params[:user_id])
  # end
end 
