class Comment < ActiveRecord::Base
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :content, presence: true, length: { minimum: 1, maximum: 200}

  default_scope -> { order('updated_at DESC') }

  belongs_to :user
  belongs_to :course

end
