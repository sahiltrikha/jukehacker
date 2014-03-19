class CreatePlayedSongs < ActiveRecord::Migration
  def change
    create_table :played_songs do |t|
      t.references :party
      t.references :song
      t.references :user
      t.integer :upvotes
      t.integer :downvotes
      t.timestamps
    end
  end
end
