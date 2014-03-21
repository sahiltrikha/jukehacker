class PlayedSongsController < ApplicationController
  def create
    PlayedSong.create(
      {party_id: params[:party_id], song_id: params[:song_id]}
      )
  end
end