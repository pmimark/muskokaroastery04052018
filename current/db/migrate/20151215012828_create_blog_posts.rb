class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :name
      t.string :slug
      t.text :body
      t.string :keywords
      t.string :description
      t.integer :blog_category_id
      t.boolean :is_draft
      t.timestamps
    end

    add_index :blog_posts, :blog_category_id
    add_index :blog_posts, :slug
  end
end
