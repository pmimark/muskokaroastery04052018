class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :slug
      t.text :body
      t.string :keywords
      t.string :description
      t.integer :section_id
      t.integer :position
      t.boolean :hidden
      t.text :intro
      t.timestamps
    end

    add_index :pages, :position
    add_index :pages, :section_id
    add_index :pages, :slug
  end
end
