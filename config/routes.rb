Meetformeal::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  get '/home', to: 'home#main'
  devise_for  :users,
              controllers:  { registrations: 'registrations' },
              path_names:   {
                              sign_in:  'login',
                              sign_up:  'signup',
                              sign_out: 'logout'
                            }
  resources :users, only: :show
end
