require 'spec_helper'

describe QueuedSongsController do

  describe "get #get_queue" do

    it "responds successfully to a request" do
      # creates early conditions
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

      # adds the items to the queue
      @party.upcoming_songs << @song
      @party.upcoming_songs << @song2

      # calls the controller method
      get :get_queue, {id: @party.id}

      # Ensures that the response succeeds
      expect(response).to be_success
      expect(response.status).to eq(200)

      # Checks the Content
      expect(JSON(response.body).first["title"]).to eq(@song.title)
    end

  end

end