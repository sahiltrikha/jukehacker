require 'spec_helper'

describe QueuedSongsController do

  describe "get #get_queue" do

    it "responds successfully to a request" do
      get :get_queue
      expect(response).to be_success
      expect(response.status).to eq("200")
    end

  end

end