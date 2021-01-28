class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.integer :comment_id
      t.integer :user_id
      t.string :reply_content

      t.timestamps
    end
  end
end
