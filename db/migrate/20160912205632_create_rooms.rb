class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :location
      t.integer :size
      t.boolean :is_existing, :default=>true

      t.timestamps
    end
  end
end
