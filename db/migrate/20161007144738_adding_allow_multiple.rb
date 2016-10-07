class AddingAllowMultiple < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|

      t.boolean :allow_multiple, :default=>false


    end
  end
end
