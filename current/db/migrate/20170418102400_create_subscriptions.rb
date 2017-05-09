class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.integer :period
      t.datetime :effective_date
      t.string :status
      t.string :code, unique: true
      t.integer :order_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
