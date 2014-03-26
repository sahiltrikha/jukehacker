class QueuedSongsController < ApplicationController
  include GroovesharkSearchHelper

  def create
    @user_party = Party.find_by(id: request.referer.split("/").last.to_i)
    @songstring = params[:songstring]
    @party_id = request.referer.split("/").last.to_i
    getGrooveshark("#{@songstring}", @party_id, @user_party.id)
    render json: Song.last

  end 

  def get_queue
    # Returns the full queue for a party
    @party = Party.find(request.referer.split("/").last.to_i)
    @queue = @party.queued_songs.order(total_votes: :desc)
    render json: @queue.map{|entry| entry.song}
  end

  def get_next_song
    # Finds the oldest song remaining to play for a given party
    unless QueuedSong.find_by(party_id: request.referer.split("/").last.to_i).nil?
      playlist = QueuedSong.where(party_id: request.referer.split("/").last.to_i)
      ordered_playlist = playlist.order(total_votes: :desc)
      @song = ordered_playlist.first.song
    else
      @song = ["DONE"]
    end

    render json: @song
  end

  def destroy
    @song = QueuedSong.find_by(song_id: params[:song_id], party_id: params[:party_id])
    @song.destroy
    render json: Song.all
  end

  def get_information
    playlist = QueuedSong.where(party_id: request.referer.split("/").last.to_i)
    ordered_playlist = playlist.order(total_votes: :desc)
    @song = ordered_playlist.first
    render json: @song
  end

  private

  # def load_user
  #   return @user = User.find(params[:user_id])
  # end
end 
