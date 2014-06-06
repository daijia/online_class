class Letter < ActiveRecord::Base

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :content, length: { minimum: 1, maximum: 2000 }

  default_scope -> { order('created_at DESC') }

  belongs_to :user, class_name: "User", foreign_key:"receiver_id"
  belongs_to :sender, class_name: "User", foreign_key:"sender_id"
end
