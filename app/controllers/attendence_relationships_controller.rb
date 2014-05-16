class AttendenceRelationshipsController < ApplicationController
  before_action :signed_in_user
  before_action :local_store_location

  def create
    @user = User.find(params[:friendship][:friend_id])
    current_user.be_friend_with(@user)
    if current_user.friend_requests.exists?(sender_id: @user.id)
      current_user.friend_requests.find_by(sender_id: @user.id).destroy
      @user.friend_request_replies.create(sender_id: current_user.id)
    end
    redirect_back_or @user
  end

  def destroy
    @user = Friendship.find(params[:id]).friend
    current_user.not_be_friend_with(@user)
    redirect_back_or @user
  end

end
