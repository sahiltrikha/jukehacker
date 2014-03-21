class FixSongDuration < ActiveRecord::Migration
  def change
    change_table(:songs) do |t|
      t.remove :length
      t.integer :duration
    end
  end
end
