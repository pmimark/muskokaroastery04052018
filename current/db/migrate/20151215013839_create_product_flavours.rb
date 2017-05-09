class CreateProductFlavours < ActiveRecord::Migration
  def change
    create_table :product_flavours do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :position
      t.boolean :out_of_stock
      t.timestamps
    end

    add_index :product_flavours, :position
    add_index :product_flavours, :slug
  end
end
