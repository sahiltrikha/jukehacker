require 'spec_helper'
include GroovesharkSearchHelper

describe "#getGrooveshark"do

   


  context "The Song Title Already Exists in our DB" do 
  
    it "should return a value from the Song DB" do 
    end

    it "should add a Queued Song with the Song ID as a foreign Key" do 
    end

  end   

  context "The Song Title does NOT exit in our DB" do 
  
    it "should add a record to the Song Table in the DB" do 
    end

    it "should add a Queued Song with the Song ID as a foreign Key" do 
    end
  end  


  it "should return a value from Grooveshark" do 
    songstring = "TinyDancer"
    binding.pry
    getGrooveshark(songstring,1,1)

    # , {songstring: songstring,party_id: 1,user_id: 1}

    
    expect(song).not_to be(nil)
  end

end 

