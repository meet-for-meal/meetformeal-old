require 'spec_helper'

feature 'Announcement show' do
  let!(:user) { create(:user) }

  background do
    login_with(user)
  end

  describe 'a non-created announcement' do
    scenario 'redirects to homepage' do
      visit user_announcement_path(user, 1)
      expect(current_path).to eq(homepage_path)
      expect(page).to display_flash_message("This announcement can't be found.")
    end
  end

end
