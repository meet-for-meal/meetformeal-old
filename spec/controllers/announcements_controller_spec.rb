require 'spec_helper'

describe AnnouncementsController do
  let(:user) { create(:user) }

  before (:each) do
    sign_in user
  end

  describe 'POST #create' do
    describe 'with correct parameters' do
      let(:announcement) { build(:announcement) }
      let(:parameters) { announcement.attributes }

      it 'creates a new announcement' do
        post :create, announcement: parameters
        filter = { lat: announcement.lat, lng: announcement.lng }
        expect(Announcement.where(filter)).to exist
      end

      it 'redirects to Announcement' do
        post :create, announcement: parameters
        expect(response).to redirect_to(user_announcement_path(user, Announcement.last.id))
      end
    end

    describe 'with invalid parameters' do
      let(:announcement) { build(:announcement, lat: '') }
      let(:parameters) { announcement.attributes }

      it 'does not create new announcement' do
        post :create, announcement: parameters
        expect(Announcement.all).to be_empty
      end

      it 're-renders the creation form' do
        post :create, announcement: parameters
        assigned = assigns(:announcement)
        expect(response).to render_template(:new)
        expect(assigned.lat).to eq(announcement.lat)
        expect(assigned.lng).to eq(announcement.lng)
      end
    end
  end

  describe 'GET #near' do
    let(:another_user) { create(:user) }
    let(:announcement) { create(:announcement, user: another_user) }

    it 'responds successfully with an HTTP 200 status code' do
      get :near
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'renders json' do
      get :near
      expect(JSON.parse(response.body))
    end

    it 'returns an array of Announcement' do
      get :near, lat: announcement.lat, lng: announcement.lng
      expect(JSON.parse(response.body)).to be_a_kind_of Array
    end

    it 'returns an error if "lat" and "lng" not provided' do
      get :near
      json = response.body
      expect({
        error: "You must provide 'lat' and 'lng' parameters",
        status: 400
      }.to_json).to be_json_eql(json)
    end

    it 'contains at least one announcement' do
      get :near, lat: announcement.lat, lng: announcement.lng
      json = response.body
      expect(json).to include_json(announcement.to_json).excluding('user', 'user_id')
    end

    it "contains announcements' user information" do
      get :near, lat: announcement.lat, lng: announcement.lng
      json = response.body
      first_announcement = JSON.parse(json).first.to_json
      expect(json).to have_json_path('0/user')
      expect(json).to have_json_path('0/user/name')
      expect(first_announcement).to include_json(another_user.to_json).excluding('id', 'email')
    end
  end
end
