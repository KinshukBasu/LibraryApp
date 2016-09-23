class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :room_number
      t.string :address
      t.boolean :isAvailable

      t.timestamps
    end
  end
end
