class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :province
      t.string :country
      t.string :postal
      t.string :phone
      t.string :phone
      t.string :email
      t.float :total
      t.integer :order_status_id
      t.datetime :purchased_at
      t.string :company
      t.string :address_optional
      t.string :shipping_address
      t.string :shipping_address_optional
      t.string :shipping_city
      t.string :shipping_province
      t.string :shipping_country
      t.string :shipping_postal
      t.string :shipping_notes
      t.string :shipping_phone
      t.boolean :billing_same_as_shipping
      t.float :shipping_rate
      t.float :subtotal
      t.float :shipping_fees
      t.boolean :include_in_mailinglist
      t.string :shipping_name
      t.boolean :free_shipping
      t.float :discount_percentage
      t.float :discount_price
      t.timestamps
    end

    add_index :orders, :order_status_id
  end
end
