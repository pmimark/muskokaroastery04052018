class CreateDiscountsProducts < ActiveRecord::Migration
  def change
    create_table :discounts_products do |t|
      t.integer :discount_id
      t.integer :product_id
    end

    add_index :discounts_products, :discount_id
    add_index :discounts_products, :product_id
  end
end
