class CreateUserBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :status
      t.boolean :favorite
      t.float :rating_point

      t.timestamps
    end
  end
end
