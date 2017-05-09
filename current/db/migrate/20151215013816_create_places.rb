class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :province
      t.string :country
      t.string :postal
      t.string :contact
      t.string :email
      t.string :phone
      t.text :website
      t.text :notes
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.text :generated_address
      t.text :description
      t.timestamps
    end

    add_index :places, :latitude
    add_index :places, :longitude
  end
end
