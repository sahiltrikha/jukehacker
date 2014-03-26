class PlayedSongsController < ApplicationController
  def create
    @newsong = PlayedSong.create(
      {party_id: params[:party_id].to_i, song_id: params[:song_id].to_i, upvotes: params[:upvotes].to_i, downvotes: params[:downvotes].to_i, total_votes: params[:total_votes].to_i, user_id: params[:user_id].to_i}
      )
    render json: @newsong
  end
end