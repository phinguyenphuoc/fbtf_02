class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :tour_id
      t.integer :quantity
      t.integer :status, default: 0, null: false
      t.float :bill
      t.string :name
      t.integer :phonenumber
      t.string :address
      t.string :note

      t.timestamps
    end
  end
end
