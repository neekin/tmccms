class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_name
      t.string :role_auth_ids
      t.string :role_auth_ac

      t.timestamps null: false
    end
  end
end
