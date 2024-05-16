class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.integer :document
      t.string :province
      t.integer :postalcode

      t.timestamps
    end
  end
end
