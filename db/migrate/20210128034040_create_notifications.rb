class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :type
      t.text :content

      t.timestamps
    end
  end
end
