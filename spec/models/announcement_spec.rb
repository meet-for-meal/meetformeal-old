require 'spec_helper'

describe Announcement do
  it 'creates a new instance given a valid attribute' do
    create :announcement
  end

  describe 'fields' do
    it_behaves_like 'a model with the following database columns',
                    [:user_id, :integer],
                    [:longitude, :float],
                    [:latitude, :float]

    it_behaves_like 'a model with timestampable columns'
  end

  describe 'validations' do
    it { should validate_presence_of :longitude }
    it { should validate_presence_of :latitude }
  end
end
