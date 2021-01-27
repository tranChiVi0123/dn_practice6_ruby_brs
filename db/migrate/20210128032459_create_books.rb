class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.time :published_time
      t.integer :page_num, null: false, default: 50
      t.string :image
      t.string :author, null: false, default: :NoName
      t.float :total_rating_point, null: false, default: 0.0
      t.text :category_id

      t.timestamps
    end
  end
end
