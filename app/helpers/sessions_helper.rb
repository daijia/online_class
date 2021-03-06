module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "请先登录"
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.hash(User.new_remember_token))
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath if request.get?
  end

  def local_store_location
    session[:return_to] ||= request.referer
  end

  def is_friend_with?(user)
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: user.id)
    if friendship
      return true
    else
      return false
    end
  end

  def array_with_index(arr, start_at=0)
    result = []
    (0..arr.length-1).each do |i|
      result.push([arr[i], (i + start_at)])
    end
    return result
  end

  def get_course_status_des(index)
    arr_status = ["尚未开始", "已经开始", "已经结束"]
    if index >= 0 || index < arr_status.length
      return arr_status[index]
    else
      return "error status"
    end
  end


end
