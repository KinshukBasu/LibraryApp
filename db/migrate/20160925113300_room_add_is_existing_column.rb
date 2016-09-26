class RoomAddIsExistingColumn < ActiveRecord::Migration[5.0]
  def change
    change_table :rooms do |t|
      t.boolean :is_existing, :default=>true
    end

  end
end
