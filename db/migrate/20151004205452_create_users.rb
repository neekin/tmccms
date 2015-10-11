class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :avatar
      t.string :email
      t.string :phone
      t.string :auth_token
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
