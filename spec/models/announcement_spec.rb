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
end
