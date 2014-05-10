module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def get_all_gender()
    return ["未填写", "男", "女"]
  end

  def get_all_degree()
    return ["未填写", "小学", "初中", "高中", "本科", "硕士", "博士"]
  end

  def get_degree_des(degree_id)
    degrees = get_all_degree
    if degree_id >= degrees.length && degree_id < 0
      return "错误学历id"
    end
    return degrees[degree_id]
  end

  def get_gender_des(gender_id)
    genders = get_all_gender
    if gender_id >= genders.length && gender_id < 0
      return "错误性别id"
    end
    return genders[gender_id]
  end

  def get_age_des(age)
    if age == 0
      return "未填写"
    end
    return age.to_s
  end


  def get_description_des(description)
    if description == ""
      return "一句话介绍一下自己吧，让别人更了解你"
    end
    return description
  end

  def array_with_index(arr)
    result = []
    (0..arr.length-1).each do |i|
      result.push([arr[i], i])
    end
    return result
  end


end
