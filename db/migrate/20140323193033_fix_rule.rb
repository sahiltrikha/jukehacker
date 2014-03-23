class FixRule < ActiveRecord::Migration
  def change
    change_table :rules do |t|
      t.remove :party_id
    end

    create_table :party_rules do |t|
      t.references :rule
      t.references :party
    end
    
  end
end
