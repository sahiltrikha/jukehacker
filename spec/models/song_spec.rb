require 'spec_helper'

describe Song do
  it {should have_many(:played_songs)}
  it {should have_many(:queued_songs)}
  it {should validate_presence_of(:grooveshark_id)}
  it {should validate_uniqueness_of(:grooveshark_id)}
  it {should validate_presence_of(:duration)}
  
end
