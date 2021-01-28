class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :book_id
      t.text :review_content

      t.timestamps
    end
  end
end
