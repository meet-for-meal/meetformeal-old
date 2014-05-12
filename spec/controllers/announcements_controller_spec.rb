require 'spec_helper'

describe AnnouncementsController do

  describe 'showing a non-created announcement' do
    it "doesn't work" do
      get :show, id: 1
      expect(response).not_to be_success
    end
  end

end
