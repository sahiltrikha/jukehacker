class QueuedSongsController < ApplicationController
  include GroovesharkSearchHelper

  # before_action :load_user
  
  def create
    @user_party = Party.find_by(id: params[:party_id])
    @songstring = params[:songstring]
    @party_id = params[:party_id]
    binding.pry
    getGrooveshark("#{@songstring}", "#{@party_id}", "#{@user_party.id}")

  end 

  def get_queue
    @party = Party.find(params[:id])
    render json: @party.upcoming_songs
  end



  private

  # def load_user
  #   return @user = User.find(params[:user_id])
  # end
end 
