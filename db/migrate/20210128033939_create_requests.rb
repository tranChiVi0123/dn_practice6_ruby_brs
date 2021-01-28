class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.text :request_content
      t.integer :status

      t.timestamps
    end
  end
end
