class PartiesController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    @party = Party.create(party_params)
    @party.party_expiry = @party.created_at + 6.hours
    @party.save
    redirect_to "/party-dashboard/#{@party.id}"
  end

  private

  def party_params
    params.require(:party).permit(:party_key)
  end
end