require 'spec_helper'

feature 'User profile' do
  let!(:user) { FactoryGirl.create(:user) }

  background do
    login_with(user)
    visit homepage_path
    click_link 'Edit account'
  end

  describe 'change password' do
    background do
      within 'form.edit_user' do
        find('#user_password').set 'new password'
        find('#user_password_confirmation').set 'new password'
        find('#user_current_password').set 'password'

        click_button 'Update'
      end
    end

    scenario 'an user can see flash message' do
      page.should display_flash_message('Votre compte a été modifié avec succès.')
    end

    scenario 'an user should be able to login with new password' do
      logout
      login_with(user, password: 'new password')
      page.should display_flash_message('Connecté(e).')
    end
  end
end
