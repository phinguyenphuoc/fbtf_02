class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.integer :category_id
      t.integer :travelling_id
      t.float :price
      t.datetime :time_start
      t.datetime :time_end
      t.string :title
      t.text :description
      t.integer :recent_quantity
      t.integer :max_quantity
      t.string :avatar
      t.float :average_rating

      t.timestamps
    end
  end
end
