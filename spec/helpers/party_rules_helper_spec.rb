require 'spec_helper'
  include PartyRulesHelper

describe "Party Rules Helper" do 
  before do
     @user1 = User.create(
        phone_number: "+16103315573", 
        first_name: "Michael", 
        last_name: "Wagner"
      )

     @host = Host.create(
        user_id: @user1.id, 
        email: "michael.k.wagner@gmail.com", 
        password: "winner", 
        password_confirmation: "winner",
        zip: 10128
      )

     @party1 = Party.create(
        host_id: @host.id, 
        party_key: "#wagparty", 
        party_expiry: Time.now + 5*60 
      )

     @song1 = Song.create(
        grooveshark_id: 408271,
        title: "Oxford Comma",
        artist: "Vampire Weekend",
        duration: 196000
      )


     @rule = Rule.create(  
      party_id: @party1.id, 
      condition: "artist", 
      banned_value: "Justin Beiber")
    end   

  describe "#getPartyRules"do 
    
    it "will get a hash of restricted values" do
      getPartyRules(@party1.id)
      expect(@rules_hash).to eq({:artist=>["Justin Beiber"]})
    end

  end 

  describe "#evaluatePartyRules" do 

    it "will evaluate the rules and accept a song" do 
      evaluatePartyRules(@song1, @party1.id)
      expect(@song_rejected).to eq(false)
    end

    it "will evaluate the rules and reject a song" do 
      @song2 = Song.create(
        grooveshark_id: 4108271,
        title: "Boyfriend",
        artist: "Justin Beiber",
        duration: 196000
      )
      evaluatePartyRules(@song2, @party1.id)
      expect(@song_rejected).to eq(true)

    end


  end 

end 
