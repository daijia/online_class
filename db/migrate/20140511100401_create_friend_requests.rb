class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.integer :type
      t.boolean :is_read
      t.string :content

      t.timestamps
    end
    add_index :friend_requests, :receiver_id
  end
end
