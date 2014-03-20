require 'spec_helper'

describe Song do
  it {should have_many(:played_songs)}
  it {should have_many(:queued_songs)}
end
