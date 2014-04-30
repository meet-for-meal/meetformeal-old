require 'spec_helper'

feature 'Sign in' do
  let!(:user) { create(:user) }
  background do
    visit homepage_path
    click_link 'Login'
  end

  scenario 'an user can see the sign in form' do
    expect(page).to have_content('Log in')

    within 'form#new_user' do
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_unchecked_field('Remember me')
      expect(page).to have_button('Log in')
    end
  end

  describe 'when an user provides valid credentials' do
    background do
      within 'form' do
        fill_in 'Email', with: user.email
        find('#user_password').set 'password'

        click_button 'Log in'
      end
    end

    scenario 'he should be logged in' do
      expect(current_path).to eq(homepage_path)

      expect(page).to display_flash_message('Connecté(e).')
      expect(page).to have_link('Logout')
    end
  end
end
