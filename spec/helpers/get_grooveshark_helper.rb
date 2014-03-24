require 'spec_helper'
  include GroovesharkSearchHelper

describe "#getGrooveshark"do
  before :each do 
    User.destroy_all
    Host.destroy_all
    Party.destroy_all
    Song.destroy_all
    QueuedSong.destroy_all
    PlayedSong.destroy_all
    Rule.destroy_all
    Guest.destroy_all


    @user = User.create(
          phone_number: "+16103315573", 
          first_name: "Michael", 
          last_name: "Wagner"
          )
    @host = Host.create(
          user_id: @user.id, 
          email: "michael.k.wagner@gmail.com", 
          password: "winner", 
          password_confirmation: "winner",
          zip: 10128
          )
    @party = Party.create(
          party_key: "#test", 
          host_id: @host.id,
          party_expiry: Time.now + 5*60 
          )
    @song = Song.create(
          grooveshark_id: 936496,
          title: "Me and Julio down by the School",
          artist: "Paul Simon",
          duration: 163000
          )
    @song2 = Song.create(
          grooveshark_id: 25133412,
          title: "Enter Sandman",
          artist: "Metallica",
          duration: 332000
          )
  
  end 


  context "The Song Title Already Exists in our DB" do 
  
    it "should add a Queued Song with the Song ID as a foreign Key" do 
      songstring = "Enter Sandman"
      @queuedsong = QueuedSong.find_by(song_id: @song2.id)
      expect(@queuedsong).to be(nil)

      getGrooveshark(songstring, @party.id, @user.id) 
      @queuedsong = QueuedSong.find_by(song_id: @song2.id)

      expect(@song2.id).to eq(@queuedsong.song_id)
    end

  end   

  context "The Song Title does NOT exit in our DB" do 
  
    it "should add a record to the Song Table in the DB" do 
      songstring = "Tiny Dancer"
      @tinydancer = Song.find_by(title: "Tiny Dancer")
      expect(@tinydancer).to be(nil)
      getGrooveshark(songstring, @party.id, @user_id)
      @tinydancer = Song.find_by(title: "Tiny Dancer")
      expect(@tinydancer).not_to be(nil)

    end 

end 
