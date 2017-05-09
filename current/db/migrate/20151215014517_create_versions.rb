class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :item_type
      t.integer :item_id
      t.string :event
      t.string :whodunnit
      t.text :object
      t.timestamps
    end

    add_index :versions, :item_id
    add_index :versions, :item_type
  end
end
