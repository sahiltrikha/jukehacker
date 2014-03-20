class PlayedSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :party
end
