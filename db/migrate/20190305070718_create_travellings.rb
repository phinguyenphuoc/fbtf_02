class CreateTravellings < ActiveRecord::Migration[5.2]
  def change
    create_table :travellings do |t|
      t.integer :location_start_id
      t.integer :location_end_id

      t.timestamps
    end
  end
end
