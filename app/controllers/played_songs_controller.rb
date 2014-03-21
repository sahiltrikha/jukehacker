class PlayedSongsController < ApplicationController
  def create
    @newsong = PlayedSong.create(
      {party_id: params[:party_id], song_id: params[:song_id]}
      )
    render json: @newsong
  end
end