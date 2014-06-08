class CommentsController < ApplicationController
  before_action :signed_in_user


  def create
    @course = Course.find(params[:course_id])
    unless @course.students.exists?(current_user.id)
      flash[:error] = "无权限评论"
      redirect_to root_path and return
    end
    content = params[:content].strip
    if content.length == 0 || content.length > 200
      flash[:error] = "评论不为空，且不能超过200字"
      redirect_to @course and return
    end
    if @course.comments.exists?(user_id: current_user.id)
      @course.comments.find_by(user_id: current_user.id).update_attributes(content: content)
    else
      @course.comments.create(user_id: current_user.id, content: content)
    end
    redirect_to @course
  end

  def destroy
    @comment = Comment.find(params[:id])
    unless @comment
      flash[:error] = "不存在评论"
      redirect_to root_path and return
    end
    @course = @comment.course
    if current_user?(@comment.user)
      @comment.destroy
    else
      flash[:error] = "无权限"
    end
    redirect_to @course
  end

end
