class CreateReservations < ActiveRecord::Migration[8.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :parking_spot, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :status, default: 0, null: false
      t.string :license_plate, null: false

      t.timestamps
    end

    add_index :reservations, [:user_id, :date], unique: true
    add_index :reservations, [:parking_spot_id, :date, :status], name: "index_reservations_on_spot_date_status"
  end
end
