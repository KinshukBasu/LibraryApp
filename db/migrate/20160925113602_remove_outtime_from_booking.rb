class RemoveOuttimeFromBooking < ActiveRecord::Migration[5.0]
  def change
    change_table :bookings do |t|
      t.remove :outtime
    end
  end
end
