class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.all
  end

  # GET /announcements/search
  def search
    permitted_params = params.permit(:time_from, :time_to, :interests)
    filter = {}
    now = DateTime.now
    zone = now.zone.to_i.hours

    # time_from filter
    if permitted_params.has_key?(:time_from) && !permitted_params[:time_from].empty?
      time_from = permitted_params[:time_from].to_i
      range = (now.change(hour: time_from) - 1.hours + zone)..(now.change(hour: time_from) + 1.hour + zone)
      filter[:time_from] = range
    end

    # time_to filter
    if permitted_params.has_key?(:time_to) && !permitted_params[:time_to].empty?
      time_to = permitted_params[:time_to].to_i
      range = (now.change(hour: time_to) - 1.hours + zone)..(now.change(hour: time_to) + 1.hour + zone)
      filter[:time_to] = range
    end

    # Retreiving
    @announcements = (filter.keys.size > 0 ? Announcement.where(filter) : Announcement.all)
                      .includes(owner: [:foods, :hobbies]).limit(5)

    # Interets filter
    if permitted_params.has_key?(:interests) && !permitted_params[:interests].empty?
      @announcements.to_a.select! do |announcement|
        announcement.owner.hobby_list.include?(permitted_params[:interests]) ||
        announcement.owner.food_list.include?(permitted_params[:interests])
      end
    end
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    @owner = @announcement.owner
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.owner = current_user

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to user_announcement_path(current_user, @announcement), notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: user_announcement_path(current_user, @announcement) }
      else
        flash[:error] = 'Please provide correction values.'
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

  # GET /announcements/near
  def near
    permitted = params.permit(:lat, :lng, :limit)
    unless permitted.has_key?('lat') && permitted.has_key?('lng')
      return render json: { error: "You must provide 'lat' and 'lng' parameters", status: 400 }
    end
    limit = permitted[:limit].nil? ? 5 : permitted[:limit]
    render json: Announcement
                  .near(current_user.id, permitted['lat'], permitted['lng'])
                  .limit(limit)
                  .to_json({
                    :include => [{ owner: { only: [:id, :name] } }],
                    :only    => [:id, :title, :lat, :lng, :time_from, :time_to]
                  })
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
      params.require(:announcement).permit(:title, :description, :time_from, :time_to, :lat, :lng)
    end
end
