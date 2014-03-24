class Party < ActiveRecord::Base
  # relationships
  has_many :upcoming_songs, through: :queued_songs, source: :song
  has_many :past_songs, through: :played_songs, source: :song
  has_many :queued_songs
  has_many :played_songs
  belongs_to :host
  has_and_belongs_to_many :rules

  # validations
  validates :party_key, presence: true
  validate :each_key_must_be_unique_when_valid, on: :create

  def each_key_must_be_unique_when_valid
    valid_keys = Party.select {|party| party.party_expiry > DateTime.now}
    valid_keys.map! {|party| party.party_key}
    errors.add(:party_key, "is already in use for a different party") if valid_keys.include?(self.party_key)
  end
end
