class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :book_id
      t.text :content
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
