Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  get '/home', to: 'home#main', as: 'home_page'
  devise_for  :users,
              controllers:  { registrations: 'registrations' },
              path_names:   {
                              sign_in:  'login',
                              sign_up:  'signup',
                              sign_out: 'logout'
                            }
  resources :users, only: :show
end
