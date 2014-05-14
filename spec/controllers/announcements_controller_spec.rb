require 'spec_helper'

describe AnnouncementsController do
  let(:user) { create(:user) }

  before (:each) do
    sign_in user
  end

  describe 'GET #near' do
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
      announcement = build(:announcement)
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
      announcement = create :announcement
      get :near, lat: announcement.lat, lng: announcement.lng
      json = response.body
      expect(json).to include_json(announcement.to_json).excluding('user', 'user_id')
    end

    it "contains announcements' user information" do
      announcement = create :announcement, user: user
      get :near, lat: announcement.lat, lng: announcement.lng
      json = response.body
      expect(json).to have_json_path('0/user')
      expect(json).to have_json_path('0/user/name')
    end
  end
end
