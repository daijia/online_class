class StaticPagesController < ApplicationController
  def home

  end

  def help
    Pusher['test_channel'].trigger('my_event', {
        message: 'hello world'
    })
  end

  def about
    Pusher['test_channel'].trigger('my_event', {
        message: 'hello world'
    })
  end

  def contact

  end

  def search_helper
    if !params[:content]
      @content = ""
    else
      @content = params[:content].strip
    end
    if params[:search_type].to_i != 1
      @search_type = 0
    else
      @search_type = 1
    end
    if params[:course_type]
      index = index_in_array(params[:course_type], get_all_course_category())
      if index > 0
        @course_type = index
      else
        @course_type = 0
      end
    else
      @course_type = 0
    end

    if params[:user_degree]
      index = index_in_array(params[:user_degree], get_all_degree())
      if index > 0
        @user_degree = index
      else
        @user_degree = 0
      end
    else
      @user_degree = 0
    end

    if params[:user_gender]
      index = index_in_array(params[:user_gender], get_all_gender())
      if index > 0
        @user_gender = index
      else
        @user_gender = 0
      end
    else
      @user_gender = 0
    end

  end

  def search_simple
    @has_search = false
    search_helper
    render 'search'
  end

  def search
    search_helper

    if @content == ""
      flash[:error] = "搜索内容不能为空"
      redirect_to :action => 'search_simple' and return
    end
    @has_search = true
    # search course
    @has_search = true
    if @search_type == 0
      options = ""
      if @course_type != 0
        options = " and category_id = '#{@course_type}'"
      end
      @courses = Course.where("name LIKE '%#{@content}%' and kind = '1'" + options)
      if signed_in?
        @private_courses = []
        current_user.friends.each do |friend|
          tmp_courses = friend.courses.where("name LIKE '%#{@content}%' and kind = '0'" + options)
          if tmp_courses
            @private_courses += tmp_courses
          end
        end
        @courses = @private_courses + @courses
      end
      render 'search' and return
    end

    # search user

    degree_option = ""
    gender_option = ""
    if @user_degree != 0
      degree_option = " and degree = '#{@user_degree}'"
    end
    if @user_gender != 0
      gender_option = " and gender = '#{@user_gender}'"
    end
    @users = User.where("name LIKE '%#{@content}%' " + degree_option + gender_option)
    render 'search' and return


  end
end
