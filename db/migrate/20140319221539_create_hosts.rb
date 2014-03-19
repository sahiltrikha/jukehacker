class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.references :user
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.integer :zip
      t.timestamps
    end
  end
end
