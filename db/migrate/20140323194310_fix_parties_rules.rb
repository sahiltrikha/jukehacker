class FixPartiesRules < ActiveRecord::Migration
  def change
    rename_table :party_rules, :parties_rules
  end
end
