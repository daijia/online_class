class FriendRequestsController < ApplicationController
  before_action :signed_in_user
  before_action :local_store_location

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
    sender_id = params[:sender_id]
    category = params[:category]
    if current_user.notices.exists?(sender_id: sender_id, category: category)
      current_user.notices.find_by(sender_id: sender_id, category: category).destroy
    end
    flash[:notice] = "已删除消息"
    redirect_back_or notice_user_path(current_user.id)

  end

end