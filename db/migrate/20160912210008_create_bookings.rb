class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :userid
      t.integer :room_no
      t.datetime :intime
      t.string :booking_status, :default=>'booked'

      t.timestamps
    end
  end
end
