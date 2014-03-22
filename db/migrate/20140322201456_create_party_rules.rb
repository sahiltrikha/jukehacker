class CreatePartyRules < ActiveRecord::Migration
  def change
    create_table :party_rules do |t|
      t.references :party
      t.string :condition
      t.string :banned_value
      t.timestamps
    end
  end
end
