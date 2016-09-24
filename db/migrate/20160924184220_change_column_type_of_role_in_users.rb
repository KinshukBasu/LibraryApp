class ChangeColumnTypeOfRoleInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :role, :integer
    change_column :users, :phoneNumber, :string
  end
end
