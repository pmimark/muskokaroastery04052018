class CreateProductQualities < ActiveRecord::Migration
  def change
    create_table :product_qualities do |t|
      t.string :name
      t.string :slug
      t.string :kind
      t.integer :value
    end

    add_index :product_qualities, :kind
    add_index :product_qualities, :slug
    add_index :product_qualities, :value
  end
end
