class QueuedSongsVotes < ActiveRecord::Migration
  def change
      change_table(:queued_songs) do |t|
      t.integer :total_votes
    end
  end
end



    
