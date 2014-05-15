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

end
