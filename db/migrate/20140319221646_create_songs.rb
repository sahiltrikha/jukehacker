class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :grooveshark_id
      t.string :title
      t.string :artist
      t.integer :length
      t.integer :grooveshark_artist
      t.timestamps
    end
  end
end
