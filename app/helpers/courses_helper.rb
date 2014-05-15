module CoursesHelper
  def get_all_course_category
    return %w[未分组 数学 语文 英语 物理 化学 历史 政治 生物 地理 艺术 生命科学 商业和管理 计算机科学 经济和金融 教育学] +
    %w[能源和地球科学 食物和营养学 健康和社会 人文学科 信息、技术和设计 法律 医学 音乐、电影和音频 物理和地球科学 社会科学]
  end

  def get_all_course_status(course)
    if course.start?
      return ["已经开始", "已经结束"]
    else
      return ["尚未开始", "已经开始", "已经结束"]
    end
  end

  def get_course_kind_res(kind)
    arr_kind = ["私人课程", "公共课程"]
    if kind >= 0 && kind < arr_kind.length
      return arr_kind[kind]
    else
      return "错误标志"
    end
  end
end
