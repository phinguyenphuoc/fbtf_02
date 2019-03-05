class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.integer :phonenumber
      t.string :password
      t.integer :role, default: 0, null: false
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
