class ChangePhoneNumber < ActiveRecord::Migration
  def change
      change_table(:users) do |t|
      t.remove :phone_number
      t.string :phone_number
    end
  end
end
