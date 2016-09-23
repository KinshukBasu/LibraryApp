class ChangeRoomsRemoveNoChangeSize < ActiveRecord::Migration[5.0]
  def change
    change_table :rooms do |t|
      t.remove :room_no
      t.change :size, :integer
      end
  end
end
