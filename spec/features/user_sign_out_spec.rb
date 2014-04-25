require 'spec_helper'

feature 'Sign out' do
  background do
    user = FactoryGirl.create(:user)
    login_with(user)

    visit homepage_path
    click_link 'Logout'
  end

  scenario 'successfully sign out' do
    page.should display_flash_message('Déconnecté(e).')
    current_path.should == homepage_path
  end
end
