class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :name
      t.string :slug
      t.integer :percentage
      t.datetime :expires_at
      t.boolean :disabled
      t.timestamps
    end
  end
end
