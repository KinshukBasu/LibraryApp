class ChangeBookingStatus < ActiveRecord::Migration[5.0]
  def change
    change_table :bookings do |t|
      t.change :booking_status, :string , :default=>'booked'
    end
  end
end
