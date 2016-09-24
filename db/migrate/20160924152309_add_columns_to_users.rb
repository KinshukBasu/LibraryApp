class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address, :string
    add_column :users, :phoneNumber, :integer
    add_column :users, :email, :string
  end
end
