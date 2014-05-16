class CourseMessagesController < ApplicationController
  before_action :signed_in_user
  before_action :current_user_has_message, only: [:agree_invitation, :agree_access]
  before_action :local_store_location, only: [:quit_course_by_self, :quit_course_by_teacher]

  def add_users
    unless current_user.courses.exists?(params[:course_id])
      flash[:error] = "你不能配置他人的课程"
      redirect_to root_path
    end

    users = params[:users]
    temp_strings = users.split('@')
    friends = []
    strangers = []
    unfound_users = []
    temp_strings.each do |str|
      user_name = str.strip
      if user_name != ""
        user = User.find_by(name: user_name)
        if user && !current_user?(user)
          if is_friend_with?(user)
            friends.push(str)
            user.add_course_message(course_id: params[:course_id],
                                                  sender_id: current_user.id,
                                                  content: params[:content],
                                                  category: get_course_message_category("t_pull_s"))
            course = current_user.courses.find(params[:course_id])
            course.add_student(user.id)
          else
            strangers.push(str)
            user.add_course_message(course_id: params[:course_id],
                                    sender_id: current_user.id,
                                    content: params[:content],
                                    category: get_course_message_category("t_invite_s"))
          end
        else
          unless current_user?(user)
            unfound_users.push(str)
          end
        end
      end
    end

    notice = ""
    if friends.length != 0
      notice += "已将好友（" + friends.join(", ") + ") 加入到课程中."
    end
    if strangers.length != 0
      notice += " 已向用户（" + strangers.join(", ") + ") 发出了邀请."
    end
    if unfound_users.length != 0
      notice += " 未找到（" + unfound_users.join(", ") + ") 这些用户."
    end
    if notice != ""
      flash[:notice] = notice
    end
    redirect_to course_path(params[:course_id])

  end

  def agree_invitation
    receiver = @message.sender
    receiver.add_course_message(sender_id: current_user.id,
                                category: get_course_message_category("s_agree_t"),
                                course_id: @message.course_id)
    @message.course.add_student(current_user.id)
    @message.destroy
    redirect_to notice_user_path(current_user.id)
  end

  def access_course
    course = Course.find(params[:course_id])
    receiver = course.teacher
    if current_user?(receiver)
      redirect_to course
    end
    receiver.add_course_message(sender_id: current_user.id,
                                category: get_course_message_category("s_ask_t"),
                                course_id: course.id)
    flash[:notice] = "已向课程老师发出请求."
    redirect_to course
  end

  def agree_access
    @message.sender.add_course_message(sender_id: current_user.id,
                                       category: get_course_message_category("t_agree_s"),
                                       course_id: @message.course_id)
    @message.course.add_student(@message.sender.id)
    @message.destroy
    redirect_to notice_user_path(current_user.id)
  end

  def quit_course_by_self
    course = Course.find(params[:course_id])
    course.remove_student(current_user.id)
    course.teacher.add_course_message(sender_id: current_user.id,
                                      category: get_course_message_category("s_quit_t"),
                                      course_id: course.id)
    flash[:notice] = "你已退出该课程"
    redirect_back_or root_path
  end


  def quit_course_by_teacher
    course = Course.find(params[:course_id])
    unless current_user?(course.teacher)
      flash[:error] = "不能编辑他人课程"
      redirect_to root_path
    end
    student = User.find(params[:user_id])
    course.remove_student(student.id)
    student.add_course_message(sender_id: current_user.id,
                               category: get_course_message_category("t_quit_s"),
                               course_id: course.id)
    flash[:notice] = "你已将" + student.name + "从" + course.name + "课程移除了"
    redirect_back_or course
  end




  def create
    receiver_id = params[:receiver_id]
    content = params[:content]
    unless receiver_id
      flash[:error] = "没有找到该用户"
      redirect_to current_user
    end
    receiver = User.find(receiver_id)
    sender_id = current_user[:id]
    if receiver.friend_requests.exists?(sender_id: sender_id)
      receiver.friend_requests.find_by_sender_id(sender_id).update_attributes(content: content, is_read: false)
    else
      if receiver.friend_requests.create(sender_id: sender_id, content: content)
        flash[:notice] = "已发送请求"
      else
        flash[:error] = "发送失败"
      end
    end
    redirect_back_or receiver
  end

  def destroy
    if current_user.course_messages.exists?(params[:message_id])
      current_user.course_messages.find(params[:message_id]).destroy
    end
    redirect_back_or notice_user_path(current_user.id)
  end

  private
    def current_user_has_message
      @message = CourseMessage.find(params[:message_id])
      unless current_user?(@message.user)
        flash[:error] = "你不能编辑他人消息"
        redirect_to root_path
      end
    end


end
