class MessagesController < ApplicationController
  before_action :signed_in_user

  def create
    lesson = Lesson.find(params[:lesson_id])
    if not lesson
      flash[:error] = "error"
      redirect_to root_path and return
    end
    if (params[:content] && params[:content].strip != "" && params[:content].strip.length <= 200 && lesson.course.can_be_seen?(current_user.id))
      lesson.messages.create(user_id: current_user.id, content: params[:content].strip)
      date = Time.new.strftime("%Y-%m-%d %H:%M:%S")
      gravatar_id = Digest::MD5::hexdigest(current_user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=52"
      Pusher['test_channel'].trigger('my_event_' + lesson.id.to_s, {
          message: current_user.id.to_s + ":" + params[:content],
          user_id: current_user.id.to_s,
          user_name: current_user.name,
          user_url: user_url(current_user.id),
          post_time: date.to_s,
          gravatar_url: gravatar_url
      })
    end
  end

end
