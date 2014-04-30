require 'spec_helper'

feature 'Admin panel' do

  describe 'an admin user' do
    let!(:user) { FactoryGirl.create(:admin) }

    background do
      login_with(user)
    end

    scenario 'should be able to access the admin panel' do
      visit rails_admin_path

      expect(current_path).to eq(rails_admin_path)
      expect(page).to have_content('Administration')
    end
  end

  describe 'a regular user' do
    let!(:user) { FactoryGirl.create(:user) }

    background do
      login_with(user)
      visit rails_admin_path
    end

    scenario 'should not be able to access the admin panel' do
      expect(current_path).to eq(homepage_path)
      expect(page).to display_flash_message('You are not authorized to access this page.')
    end
  end

end
