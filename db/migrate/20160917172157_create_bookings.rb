class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :room_id
      t.timestamps :checkin
      t.timestamps :checkout
      t.string :bookingType

      t.timestamps
    end
  end
end
