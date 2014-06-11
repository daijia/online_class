class Message < ActiveRecord::Base
  validates :lesson_id, presence: true
  validates :user_id, presence: true
  validates :content, length: {minimum: 1, maximum: 200}
  #default_scope -> { order('updated_at DESC') }


  belongs_to :user
  belongs_to :lesson

end
