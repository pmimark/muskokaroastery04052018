class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.string :slug
      t.text :description
    end

    add_index :product_types, :slug
  end
end
