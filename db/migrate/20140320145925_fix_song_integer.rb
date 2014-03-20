class FixSongInteger < ActiveRecord::Migration
  def change
    change_table(:songs) do |t|
      t.remove :grooveshark_id
      t.integer :grooveshark_id
    end
  end
end
