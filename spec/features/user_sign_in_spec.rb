require 'spec_helper'

feature 'Sign in' do
  let!(:user) { FactoryGirl.create(:user) }
  background do
    visit homepage_path
    click_link 'Login'
  end

  scenario 'an user can see the sign in form' do
    page.should have_content('Log in')

    within 'form#new_user' do
      page.should have_field('Email')
      page.should have_field('Password')
      page.should have_unchecked_field('Remember me')
      page.should have_button('Log in')
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
      current_path.should == homepage_path

      page.should display_flash_message('Connecté(e).')
      page.should have_link('Logout')
    end
  end
end
