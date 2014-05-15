class CoursesController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :new, :create, :destroy]
  before_action :correct_user_of_course,  only: [:edit, :update, :destroy]

  def show
    @course = Course.find(params[:id])
    if @course.public? || (signed_in? && current_user?(@course.teacher))
      render 'show'
    else
      flash[:error] = "你无权限查看"
      redirect_to root_path
    end

  end

  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      flash[:success] = "成功创建！"
      redirect_to @course
    else
      render 'new'
    end
  end

  def edit
    render 'edit'
  end

  def update
    if @course.update_attributes(course_params)
      flash[:success] = "课程已更新"
      redirect_to @course
    else
      render 'edit'
    end
  end


  def destroy
    Course.find(params[:id]).destroy
    flash[:success] = "课程已删除."
    redirect_to courses_user_path(current_user[:id])
  end

  private
    def correct_user_of_course()
      @course = Course.find(params[:id])
      unless current_user?(@course.teacher)
        flash[:error] = "不能编辑他人课程"
        redirect_back_or root_path
      end
    end

    def course_params
      params.require(:course).permit(:name, :category_id, :kind, :status ,
                                  :description, :knowledge, :plan, :reference)
    end


end
