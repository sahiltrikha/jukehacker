class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.references :user
      t.references :party
      t.timestamps
    end
  end
end
