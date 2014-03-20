require 'spec_helper'

describe PlayedSong do
  it {should belong_to(:party)}
  it {should belong_to(:song)}
end
