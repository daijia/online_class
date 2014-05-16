class Course < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :teacher_id, presence: true
  validates :status, presence: true
  validates :category_id, presence: true
  validates :kind, presence: true
  validates :description, length: { maximum: 2000 }
  validates :reference, length: { maximum: 1000 }
  validates :plan, length: { maximum: 1000 }
  validates :knowledge, length: { maximum: 1000 }

  default_scope -> { order('created_at DESC') }

  has_many :attendence_relationships, dependent: :destroy
  has_many :students, through: :attendence_relationships, source: :user
  has_many :course_messages, dependent: :destroy

  belongs_to :teacher, class_name: "User", foreign_key:"teacher_id"
  belongs_to :category, class_name: "CourseCategory", foreign_key:"category_id"

  def start?
    return self.status > 0
  end

  def public?
    return self.kind == 1
  end

  def private?
    return self.kind == 0
  end


  def add_student(user_id)
    unless self.attendence_relationships.exists?(user_id: user_id)
      self.attendence_relationships.create(user_id: user_id)
    end
  end

  def remove_student(user_id)
    if self.attendence_relationships.exists?(user_id: user_id)
      self.attendence_relationships.find_by(user_id: user_id).destroy
    end
  end
end
