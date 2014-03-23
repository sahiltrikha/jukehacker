class PartiesController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    @party = Party.create(party_params)
    
    # hard sets the expiration for the party at six hours in the future
    @party.party_expiry = @party.created_at + 6.hours
    @party.save
    redirect_to "/party-dashboard/#{@party.id}"
  end

  def show
    @party = Party.find(params[:id])
  end

  private

  def party_params
    params.require(:party).permit(:party_key)
  end
end