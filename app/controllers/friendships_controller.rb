class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_requested_user, only: :create

  def create
    redirect_to(homepage_path) if is_current_user? || is_already_friend? || is_pending_friend?
    current_user.request_friendship @requested_user
    redirect_to user_path @requested_user
  end

  private
    def set_requested_user
      begin
        @requested_user = User.find(params[:user_id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "This user can't be found."
        redirect_to homepage_path
      end
    end

    def is_current_user?
      @requested_user == current_user
    end

    def is_already_friend?
      current_user.is_friend_with? @requested_user
    end

    def is_pending_friend?
      current_user.pending_friends.include?(@requested_user) ||
      current_user.requested_friendships.include?(@requested_user)
    end
end
