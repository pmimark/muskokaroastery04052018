class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :position
      t.integer :page_id
      t.timestamps
    end

    add_index :sections, :page_id
    add_index :sections, :position
    add_index :sections, :slug
  end
end
