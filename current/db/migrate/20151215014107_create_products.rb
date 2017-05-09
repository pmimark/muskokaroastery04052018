class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.text :body
      t.float :price
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.boolean :is_active
      t.integer :size
      t.boolean :option_ground
      t.boolean :option_ground_decaf
      t.boolean :option_whole
      t.boolean :option_whole_decaf
      t.integer :acidity
      t.integer :body_quality
      t.integer :roast
      t.integer :product_type_id
      t.string :keywords
      t.string :description
      t.integer :position
      t.boolean :lists_all_flavours
      t.boolean :include_flavour_descriptions
      t.boolean :include_graphs
      t.string :per
      t.string :price_alt_txt
      t.boolean :out_of_stock
      t.boolean :is_special
      t.timestamps
    end

    add_index :products, :is_active
    add_index :products, :position
    add_index :products, :product_type_id
    add_index :products, :slug
  end
end
