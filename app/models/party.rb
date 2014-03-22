class Party < ActiveRecord::Base
  # relationships
  has_many :upcoming_songs, through: :queued_songs, source: :song
  has_many :past_songs, through: :played_songs, source: :song
  has_many :queued_songs
  has_many :played_songs
  belongs_to :host
  has_many :rules

  # validations
  validates :party_key, presence: true
end
