module Macros
  module UserLogin
    def login_with(user, options = {})
      options.reverse_merge!(password: 'password')

      visit homepage_url
      click_link 'Login'

      within 'form' do
        find('#user_email').set user.email
        find('#user_password').set options[:password]

        click_button 'Log in'
      end
    end

    def logout
      visit homepage_url
      click_link('Logout')
    end
  end
end
