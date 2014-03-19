class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.references :host
      t.string :party_key
      t.datetime :party_expiry
      t.timestamps
    end
  end
end
