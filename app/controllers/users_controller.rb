class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :notice, :friends, :courses, :letters, :subjects]
  before_action :correct_user,   only: [:edit, :update, :notice, :friends, :letters, :subjects]
  before_action :admin_user,     only: :destroy
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "欢迎来到良师益友！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "个人资料已更新"
      redirect_to @user
    else
      render 'edit'
    end
  end



  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户已删除."
    redirect_to users_url
  end

  def friends
    @users = current_user.friends.paginate(page: params[:page])
  end

  def notice
    @friend_requests = current_user.friend_requests
    @friend_request_replies = current_user.friend_request_replies
    @course_messages = current_user.course_messages
  end

  def courses
    @user = User.find(params[:id])
    @public_courses = @user.public_courses
    @private_courses = @user.private_courses
  end

  def subjects
    @user = User.find(params[:id])
    @courses = @user.subjects
  end

  def letters
    @all_letters = current_user.letters
    @letters = []
    @unread_letter_count = []
    @all_letters.each do |letter|
      is_first = true
      @letters.each do |compare_letter|
        if compare_letter.sender == letter.sender
          is_first = false
        end
      end
      if is_first
        @letters.push(letter)
      end
      @letters.each do |letter|
        @unread_letter_count.push(current_user.letters.where(sender_id: letter.sender_id, is_read: false).count)
      end
    end

  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :gender, :age, :degree, :description)
    end


    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end