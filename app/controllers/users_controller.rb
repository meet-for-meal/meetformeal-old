class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def show
    @is_own_profile = @user == current_user
    @are_friends = current_user.is_friend_with?(@user) unless @is_own_profile
    @title = @is_own_profile ? 'Mon profil' : "Profil de #{@user.name}"
  end

  private
    def set_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "This user can't be found."
        redirect_to homepage_path
      end
    end

end
