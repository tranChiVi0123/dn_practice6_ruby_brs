class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.time :published_time
      t.integer :page_num
      t.string :image
      t.string :author
      t.float :total_rating_point
      t.text :category_id

      t.timestamps
    end
  end
end
