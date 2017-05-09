class CreatePagesProducts < ActiveRecord::Migration
  def change
    create_table :pages_products do |t|
      t.integer :page_id
      t.integer :product_id
    end

    add_index :pages_products, :page_id
    add_index :pages_products, :product_id
  end
end
