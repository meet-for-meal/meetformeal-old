require 'spec_helper'

feature 'Sign out' do
  background do
    user = create(:user)
    login_with(user)

    visit homepage_path
    click_link 'Logout'
  end

  scenario 'successfully sign out' do
    expect(page).to display_flash_message('Déconnecté(e).')
    expect(current_path).to eq(homepage_path)
  end
end
