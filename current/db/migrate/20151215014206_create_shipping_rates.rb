class CreateShippingRates < ActiveRecord::Migration
  def change
    create_table :shipping_rates do |t|
      t.string :name
      t.string :country_code
      t.float :price
      t.float :free_price
      t.timestamps
    end
  end
end
