require 'spec_helper'

describe Party do
  # Relationship Tests
  it {should have_many(:past_songs).through(:played_songs).source(:song)}
  it {should have_many(:upcoming_songs).through(:queued_songs).source(:song)}
  it {should have_many(:queued_songs)}
  it {should have_many(:played_songs)}
  it {should belong_to(:host) }
  it {should have_many(:rules)}

  # Validation Tests
  it {should validate_presence_of(:party_key)}

end
