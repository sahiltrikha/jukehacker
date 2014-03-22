require 'spec_helper'

describe getGrooveshark do 

  describe "#getGrooveshark"do
    it "should return a value from Grooveshark" do 
    end 

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

  end 

end 