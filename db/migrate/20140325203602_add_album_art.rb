class AddAlbumArt < ActiveRecord::Migration
  def change
    add_column :songs, :album_art, :text
  end
end
