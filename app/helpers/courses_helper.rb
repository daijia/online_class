module CoursesHelper


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
