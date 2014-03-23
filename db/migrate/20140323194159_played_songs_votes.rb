class PlayedSongsVotes < ActiveRecord::Migration
  def change
      change_table(:played_songs) do |t|
      t.integer :total_votes
    end
  end
end
