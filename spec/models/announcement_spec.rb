require 'spec_helper'

describe Announcement do
  it 'creates a new instance given a valid attribute' do
    create :announcement
  end

  it 'creates a new instance with a user' do
    create :announcement_with_user
  end

  describe 'fields' do
    it_behaves_like 'a model with the following database columns',
                    [:user_id, :integer],
                    [:lat, :float],
                    [:lng, :float]

    it_behaves_like 'a model with timestampable columns'
  end

  describe 'validations' do
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lng }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'near Announcements' do
    let(:announcement) { create(:announcement, user: create(:user)) }

    it 'raison an exception without "from_user_id", "lat" and "lng" parameters provided' do
      expect { Announcement.near }.to raise_error(ArgumentError)
    end

    it 'returns an array of announcements' do
      expect(Announcement.near(0, announcement.lat, announcement.lng)).to eq([announcement])
    end

    it 'doen not include self announcements' do
      another_user = create(:user)
      another_announcement = create(:announcement, user: another_user)
      near = Announcement.near(another_user.id, announcement.lat, announcement.lng)
      expect(near).to include(announcement)
      expect(near).not_to include(another_announcement)
    end
  end
end
