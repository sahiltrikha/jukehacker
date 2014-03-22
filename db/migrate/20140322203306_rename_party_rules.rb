class RenamePartyRules < ActiveRecord::Migration
  def change
    rename_table :party_rules, :rules
  end
end
