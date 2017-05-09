class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.text :website
      t.text :comment
      t.boolean :include_in_mailinglist
      t.timestamps
    end
  end
end
