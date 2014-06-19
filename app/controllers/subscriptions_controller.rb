class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @announcements = current_user.subscribed_announcements
  end

  def create
    begin
     @announcement = Announcement.find(params[:announcement_id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "This announcement can't be found."
      return redirect_to homepage_path
    end
    if @announcement.owner == current_user
      flash[:error] = "You can't subscribe to your own announcement."
      return redirect_to homepage_path
    end
    if current_user.subscribed_to? @announcement
      flash[:error] = "You have already subscribed to this announcement"
      return redirect_to homepage_path
    end
    current_user.subscribe(@announcement)
    redirect_to user_announcement_path(@announcement.owner, @announcement)
  end
end
