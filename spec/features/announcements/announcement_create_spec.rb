require 'spec_helper'

feature 'Announcement creation' do
  let!(:user) { create(:user) }
  let(:announcement) { build(:announcement) }

  background do
    login_with(user)
    visit new_announcement_path
  end

  describe 'with a valid announcement' do
    background do
      within 'form' do
        find('#announcement_title').set announcement.title
        find('#announcement_lat').set announcement.lat
        find('#announcement_lng').set announcement.lng

        click_button 'Créer un(e) Announcement'
      end
    end

    scenario 'is created with displaying success alert message' do
      expect(page).to display_flash_message('Announcement was successfully created.')
    end
  end

  describe 'with an invalid announcement' do
    background do
      within 'form' do
        find('#announcement_lat').set ''
        find('#announcement_lng').set ''

        click_button 'Créer un(e) Announcement'
      end
    end

    scenario 'is redirected to creation form' do
      expect(page).to display_flash_message('Please provide correction values.')
    end
  end

end
