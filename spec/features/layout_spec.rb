require 'spec_helper'

feature 'Layout' do
  let!(:user) { create(:user) }

  describe 'with connected user' do
    background do
      login_with(user)
      visit homepage_path
    end

    describe 'header navbar' do
      scenario 'has proper links' do
        expect(page).to have_link('MeetForMeal', href: homepage_path)
        expect(page).to have_link('Add an announcement', href: new_announcement_path)
        expect(page).to have_link('Edit account', href: edit_user_registration_path)
        expect(page).to have_link('Logout', href: destroy_user_session_path)
      end
    end
  end

  describe 'with disconnected user' do
    background do
      visit homepage_path
    end

    describe 'header navbar' do
      scenario 'has proper links' do
        expect(page).not_to have_link('Add an announcement', href: new_announcement_path)
        expect(page).to have_link('Register', href: new_user_registration_path)
        expect(page).to have_link('Login', href: new_user_session_path)
      end
    end
  end

end
