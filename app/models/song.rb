class Song < ActiveRecord::Base

  has_many :played_songs
  has_many :queued_songs
  validates :grooveshark_id, presence: true, uniqueness: true
  validates :duration, presence: true

end



    ##Step 1:  send value to Grooveshark
    ##Step 2A:  IF value not in SONG DB Add. 
    ##Step 2B:  Add Song to the Song Queue
