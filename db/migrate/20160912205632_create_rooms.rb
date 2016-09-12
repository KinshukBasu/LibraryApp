class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :room_no
      t.string :location
      t.string :size

      t.timestamps
    end
  end
end
