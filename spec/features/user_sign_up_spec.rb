require 'spec_helper'

feature 'Sign in' do
  let!(:user) { FactoryGirl.build(:user) }
  background do
    visit homepage_path
    click_link 'Register'
  end

  describe 'when user provides valid credentials' do
    background do
      fill_in 'Name', with: user.name
      fill_in 'Email', with: user.email
      find('#user_password').set 'password'
      find('#user_password_confirmation').set 'password'

      click_button 'Register'
    end

    scenario 'he should be logged in' do
      expect(page).to display_flash_message('Bienvenue, vous êtes connecté(e)')
      expect(current_path).to eq(homepage_path)

      expect(User.find_by_email(user.email)).not_to be_nil
    end
  end
end
