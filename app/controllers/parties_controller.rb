class PartiesController < ApplicationController
  include PartyRulesHelper

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_params)

    if @party.save
      # hard sets the expiration for the party at six hours in the future
      @party.party_expiry = @party.created_at + 6.hours
      @party.save
      params[:tracks].each do |track|
        unless track == ""
          @party.rules << addRule("track", track)
        end
      end

      params[:artists].each do |artist|
        unless artist == ""
          @party.rules << addRule("artist", artist)
        end
      end

      redirect_to "/party-dashboard/#{@party.id}"
    else
      redirect_to request.referer
    end
  end

def show
  @party = Party.find(params[:id])
end

private

def party_params
  params.require(:party).permit(:party_key)
end
end