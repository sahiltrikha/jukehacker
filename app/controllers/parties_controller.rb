class PartiesController < ApplicationController
  include PartyRulesHelper

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_params)
    @party.host_id = session[:host_id]
    if @party.save
      # hard sets the expiration for the party at six hours in the future
      @party.party_expiry = @party.created_at + 6.hours
      @party.save

      # creates tracks blacklist
      params[:tracks].each do |track|
        unless track == ""
          @party.rules << addRule("track", track)
        end
      end

      # creates artist blacklist
      params[:artists].each do |artist|
        unless artist == ""
          @party.rules << addRule("artist", artist)
        end
      end

      # redirects to the party dashboard
      redirect_to "/party-dashboard/#{@party.id}"
    else

      # redirects back the the create screen
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