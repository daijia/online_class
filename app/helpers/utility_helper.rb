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

  def get_all_course_category
    return %w[未分组 数学 语文 英语 物理 化学 历史 政治 生物 地理 艺术 生命科学 商业和管理 计算机科学 经济和金融 教育学] +
        %w[能源和地球科学 食物和营养学 健康和社会 人文学科 信息、技术和设计 法律 医学 音乐、电影和音频 物理和地球科学 社会科学]
  end

  def get_all_course_category_length
    temp = get_all_course_category()
    return temp.length
  end

  def get_all_gender()
    return ["未填写", "男", "女"]
  end

  def get_all_degree()
    return ["未填写", "小学", "初中", "高中", "本科", "硕士", "博士"]
  end

  def get_all_degree_length
    temp = get_all_degree()
    return temp.length
  end

  def get_all_gender_length
    temp = get_all_gender()
    return temp.length
  end

  def index_in_array(element, arr)
    (0..arr.length-1).each do |index|
      if arr[index] == element
        return index
      end
    end
    return -1
  end
end