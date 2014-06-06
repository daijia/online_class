class LessonsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :show, :create, :update, :destroy]

  def show
    @lesson = Lesson.find(params[:id])
    @course = @lesson.course
    if @course.can_be_seen?(current_user.id)
      render 'show'
    else
      flash[:error] = "你无权限查看"
      redirect_to root_path
    end

  end

  def new
    correct_user_of_course(params[:course_id])
    @lesson = @course.lessons.build
    @lesson.start_time = DateTime.current
    @lesson.course_id = @course.id
  end

  def create
    correct_user_of_course(params[:lesson][:course_id])
    @lesson = @course.lessons.build(lesson_params)
    if @course.save
      flash[:success] = "成功创建！"
      redirect_to @lesson
    else
      render 'new'
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    correct_user_of_course(@lesson.course_id)
    render 'edit'
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update_attributes(lesson_params)
      flash[:success] = "课堂已更新"
      redirect_to @lesson
    else
      render 'edit'
    end
  end


  def destroy
    lesson = Lesson.find(params[:id])
    correct_user_of_course(lesson.course_id)
    lesson.destroy
    flash[:success] = "课堂已删除."
    redirect_to @course
  end


  private
  def correct_user_of_course(course_id)
    @course = Course.find(course_id)
    unless @course
      flash[:error] = "该页面不存在"
      redirect_to root_path
    end
    unless current_user?(@course.teacher)
      flash[:error] = "不能编辑他人课程"
      redirect_to root_path
    end
  end

  def lesson_params
    params.require(:lesson).permit(:name, :course_id, :start_time, :duration, :homework, :description)
  end


end