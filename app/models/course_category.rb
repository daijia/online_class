class CourseCategory < ActiveRecord::Base

  validates :name, presence: true
  has_many :courses, foreign_key: "category_id"
end
