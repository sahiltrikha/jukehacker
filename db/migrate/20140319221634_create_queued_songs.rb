class CreateQueuedSongs < ActiveRecord::Migration
  def change
    create_table :queued_songs do |t|
      t.references :party
      t.references :song
      t.references :user
      t.integer :upvotes
      t.integer :downvotes
      t.timestamps
    end
  end
end
