class PlayedSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :party

  validates_numericality_of :upvotes
  validates_numericality_of :downvotes
  validates_numericality_of :total_votes
  validates :song_id, presence: true
  validates :user_id, presence: true
end
