class CreateParkingSpots < ActiveRecord::Migration[8.1]
  def change
    create_table :parking_spots do |t|
      t.string :name, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :parking_spots, :name, unique: true
  end
end
