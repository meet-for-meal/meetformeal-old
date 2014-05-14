class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.all
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
    # Generate random location near center of Paris
    @announcement.latitude = rand(48.8...48.9)
    @announcement.longitude = rand(2.3...2.4)
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.user = current_user

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to user_announcement_path(current_user, @announcement), notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: user_announcement_path(current_user, @announcement) }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url }
      format.json { head :no_content }
    end
  end

  private
    def set_announcement
      begin
       @announcement = Announcement.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "This announcement can't be found."
        redirect_to homepage_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:longitude, :latitude)
    end
end
