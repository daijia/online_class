module UtilityHelper
  def get_course_message_category(category_des)
    categories = %w[t_pull_s t_invite_s s_agree_t s_ask_t t_agree_s s_quit_t t_quit_s t_destroy_s]
    (0..categories.length-1).each do |index|
      if categories[index] == category_des
        return index
      end
    end
    return -1
  end


  def get_course_message_category_des(category)
    categories = %w[t_pull_s t_invite_s s_agree_t s_ask_t t_agree_s s_quit_t t_quit_s t_destroy_s]
    if category >=0 && category < categories.length
      return categories[category]
    end
    return "error catetory"
  end

end