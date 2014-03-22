require 'spec_helper'

describe QueuedSongsController do

  describe "get #get_queue" do

    it "responds successfully to a request" do
      @party = Party.create(party_key: "test")
      @song = Song.create(
        grooveshark_id: 936496,
        title: "Me and Julio down by the School",
        artist: "Paul Simon",
        duration: 163000
        )
      @song2 = song3 = Song.create(
        grooveshark_id: 25133412,
        title: "Enter Sandman",
        artist: "Metallica",
        duration: 332000
        )

      @party.upcoming_songs << @song
      @party.upcoming_songs << @song2
      get :get_queue, {id: @party.id}
      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(JSON(response.body).first["title"]).to eq(@song.title)
    end

  end

end