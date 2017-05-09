class CreateBlogCategories < ActiveRecord::Migration
  def change
    create_table :blog_categories do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :position
      t.timestamps
    end

    add_index :blog_categories, :position
    add_index :blog_categories, :slug
  end
end
