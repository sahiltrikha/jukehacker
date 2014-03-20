require 'spec_helper'

describe Party do
  it {should have_many(:past_songs).through(:played_songs).source(:songs)}
  it {should have_many(:upcoming_songs).through(:queued_songs).source(:songs)}
  it {should have_many(:queued_songs)}
  it {should have_many(:played_songs)}
end
