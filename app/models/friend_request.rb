class FriendRequest < ActiveRecord::Base
  validates :receiver_id, presence: true
  validates :sender_id, presence: true
  validates :content, length: { maximum: 200}
  default_scope -> { order('updated_at DESC') }
  belongs_to :user, class_name: "User", foreign_key:"receiver_id"
  belongs_to :sender, class_name: "User", foreign_key:"sender_id"
end
