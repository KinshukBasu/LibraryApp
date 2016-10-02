class CreateDeletedbookings < ActiveRecord::Migration[5.0]
  def change
    create_table :deletedbookings do |t|
      t.integer :userid
      t.integer :room_no
      t.datetime :intime

      t.timestamps
    end
  end
end
