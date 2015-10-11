class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.string :auth_name
      t.integer :auth_pid
      t.string :auth_path
      t.string :auth_controller
      t.string :auth_action
      t.integer :auth_level

      t.timestamps null: false
    end
  end
end
