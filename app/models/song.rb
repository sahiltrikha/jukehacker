class Song < ActiveRecord::Base
  has_many :played_songs
  has_many :queued_songs
end
