class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.text :request_content
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
