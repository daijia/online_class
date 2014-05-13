class ChangeTypeInFriendRequest < ActiveRecord::Migration
  def change
    rename_column :friend_requests, :type, :category
    add_index :friend_requests, :updated_at
  end
end
