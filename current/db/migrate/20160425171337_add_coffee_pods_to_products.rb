class AddCoffeePodsToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.boolean :option_coffee_pods, :default => false
    end
  end
end
