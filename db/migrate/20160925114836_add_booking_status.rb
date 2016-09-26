class AddBookingStatus < ActiveRecord::Migration[5.0]
  def change
    change_table :bookings do |t|
      t.string :booking_status, :default=>'booked'
    end
  end
end
