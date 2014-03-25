require 'spec_helper'

describe QueuedSong do
  it {should belong_to(:party)}
  it {should belong_to(:song)}
  it {should validate_presence_of(:song_id)}
  it {should validate_presence_of(:user_id)}
  it {should validate_numericality_of(:upvotes)}
  it {should validate_numericality_of(:downvotes)}
  it {should validate_numericality_of(:total_votes)}
end
