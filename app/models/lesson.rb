class Lesson < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :course_id, presence: true
  validates :duration, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 300}
  validates :description, length: { maximum: 2000 }
  validates :homework, length: { maximum: 1000 }
  validates :start_time, presence: true

  belongs_to :course

  def belongs_to_user?(user_id)
    user = User.find(user_id)
    if user == self.course.teacher
      return true
    else
      return false
    end
  end

end
