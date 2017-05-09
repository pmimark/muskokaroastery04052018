class CreatePaymentNotifications < ActiveRecord::Migration
  def change
    create_table :payment_notifications do |t|
      t.text :params
      t.integer :cart_id
      t.integer :order_id
      t.string :status
      t.string :transaction_id
      t.timestamps
    end

    add_index :payment_notifications, :cart_id
    add_index :payment_notifications, :order_id
  end
end
