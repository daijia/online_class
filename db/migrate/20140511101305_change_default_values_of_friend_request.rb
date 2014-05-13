class ChangeDefaultValuesOfFriendRequest < ActiveRecord::Migration
  def change
    change_column :friend_requests, :type, :integer, default: 0
    change_column :friend_requests, :is_read, :boolean, default: false
    change_column :friend_requests, :content, :string, default: ""
  end
end
