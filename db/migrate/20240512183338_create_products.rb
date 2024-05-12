class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :description
      t.string :sku
      t.integer :stock, default: 0
      t.decimal :price, precision: 10, scale: 2, default: 0

      t.timestamps
    end
  end
end
