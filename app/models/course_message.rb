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


  def CourseMessage.get_category(category_des)
    categories = %w[t_pull_s t_invite_s s_agree_t s_ask_t t_agree_s s_quit_t t_quit_s t_destroy_s]
    (0..categories.length-1).each do |index|
      if categories[index] == category_des
        return index
      end
    end
    return -1
  end


  def get_category_des
    categories = %w[t_pull_s t_invite_s s_agree_t s_ask_t t_agree_s s_quit_t t_quit_s t_destroy_s]
    if self.category >=0 && self.category < categories.length
      return categories[self.category]
    end
    return "error catetory"
  end
end
