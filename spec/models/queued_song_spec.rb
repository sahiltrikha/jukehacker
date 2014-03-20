require 'spec_helper'

describe QueuedSong do
  it {should belong_to(:party)}
  it {should belong_to(:song)}
end
