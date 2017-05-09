class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.text :body
      t.string :link_name
      t.text :link_url
      t.string :link_type
      t.integer :page_id
      t.integer :product_id
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.boolean :is_homepage_feature
      t.integer :position
      t.boolean :is_active
      t.timestamps
    end

    add_index :features, :page_id
    add_index :features, :position
    add_index :features, :product_id
  end
end
