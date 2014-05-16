class CourseMessage < ActiveRecord::Base
  validates :receiver_id, presence: true
  validates :sender_id, presence: true
  validates :course_id, presence: true
  validates :category, presence: true
  validates :content, length: { maximum: 200}
  default_scope -> { order('updated_at DESC') }


  belongs_to :user, class_name: "User", foreign_key:"receiver_id"
  belongs_to :sender, class_name: "User", foreign_key:"sender_id"
  belongs_to :course, class_name: "Course", foreign_key:"course_id"
end
