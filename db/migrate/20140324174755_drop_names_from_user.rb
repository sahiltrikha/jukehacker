class DropNamesFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :first_name, :last_name
  end
end
