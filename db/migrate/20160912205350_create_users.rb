class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :role
      t.string :address
      t.string :phoneNumber
      t.string :email

      t.timestamps
    end
  end
end
