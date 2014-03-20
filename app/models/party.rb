class Party < ActiveRecord::Base
  has_many :upcoming_songs, through: :queued_songs, source: :songs
  has_many :past_songs, through: :played_songs, source: :songs
  has_many :queued_songs
  has_many :played_songs
end
