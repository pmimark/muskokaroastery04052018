class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :order_id
      t.float :item_price
      t.string :item_name
      t.string :item_option
      t.string :item_flavour
      t.timestamps
    end

    add_index :line_items, :order_id
    add_index :line_items, :product_id
  end
end
