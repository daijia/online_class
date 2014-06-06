class LettersController < ApplicationController
  before_action :signed_in_user
  before_action :local_store_location


  def new
    @letter = Letter.new(sender_id: current_user.id, receiver_id: params[:id])
  end

  def create
    @letter = Letter.new(letter_params)
    if @letter.user == @letter.sender
      redirect_to root_path and return
    end
    unless current_user?(@letter.sender)
      redirect_to root_path and return
    end
    if @letter.save
      flash[:success] = "已发送私信"
      redirect_to @letter.user
    else
      flash.now[:error] = "私信内容格式不正确"
      render 'new'
    end
  end

  def conversion
    @user = User.find(params[:id])
    if @user && !current_user?(@user)
      @other_user_words = current_user.letters.where(sender_id: params[:id])
      @my_words = @user.letters.where(sender_id: current_user.id)
      @letter = Letter.new(sender_id: current_user.id, receiver_id: params[:id])
      @other_user_words.each do |letter|
        letter.update_attributes(is_read: true)
      end
    else
      flash[:error] = "获取对话错误"
      redirect_to root_path
    end
  end

  def destroy
    letter = Letter.find(params[:id])
    if !letter
      flash[:error] = "错误"
      redirect_to root_path and return
    end

    if letter.user == current_user || letter.sender == current_user
      sender_id = letter.sender.id
      letter.destroy
      if current_user.letters.exists?(sender_id: sender_id)
        redirect_to :action => 'conversion', :id => sender_id
      else
        redirect_to letters_user_path(current_user)
      end

    else
      flash[:error] = "权限错误"
      redirect_to letters_user_path(current_user)
    end

  end

  private
    def letter_params
      params.require(:letter).permit(:sender_id, :receiver_id, :content)
    end
end
