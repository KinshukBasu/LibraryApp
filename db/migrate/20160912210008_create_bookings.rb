class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :userid
      t.integer :room_no
      t.datetime :intime
      t.datetime :outtime

      t.timestamps
    end
  end
end
