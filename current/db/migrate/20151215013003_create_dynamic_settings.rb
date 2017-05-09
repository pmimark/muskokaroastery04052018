class CreateDynamicSettings < ActiveRecord::Migration
  def change
    create_table :dynamic_settings do |t|
      t.string :nice_name
      t.string :name
      t.text :value
      t.timestamps
    end
  end
end
