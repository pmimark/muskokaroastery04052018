class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token
      t.integer :login_count
      t.integer :failed_login_count
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
      t.boolean :su
      t.boolean :is_admin
      t.string :address
      t.string :city
      t.string :province
      t.string :country
      t.string :postal
      t.string :phone
      t.boolean :billing_same_as_shipping
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_province
      t.string :shipping_country
      t.string :shipping_postal
      t.text :shipping_notes
      t.string :address_optional
      t.string :company
      t.string :shipping_address_optional
      t.string :shipping_phone
      t.string :name
      t.boolean :include_in_mailinglist
      t.timestamps
    end

    add_index :users, :username
  end
end
