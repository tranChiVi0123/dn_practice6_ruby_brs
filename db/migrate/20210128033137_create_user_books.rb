class CreateUserBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :status, null: false, default: 0
      t.boolean :favorite, default: 0
      t.float :rating_point

      t.timestamps
    end
  end
end
