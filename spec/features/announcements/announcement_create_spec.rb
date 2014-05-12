require 'spec_helper'

feature 'Announcement creation' do
  let!(:user) { create(:user) }
  let(:announcement) { build(:announcement) }

  background do
    login_with(user)
    visit new_announcement_path
  end

  describe 'a valid announcement' do
    background do
      within 'form' do
        find('#announcement_latitude').set announcement.latitude
        find('#announcement_longitude').set announcement.longitude

        click_button 'Créer un(e) Announcement'
      end
    end

    scenario 'is created with displaying success alert message' do
      expect(page).to display_flash_message('Announcement was successfully created.')
    end
  end

end
