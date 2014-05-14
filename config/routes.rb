Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  get '/home', to: 'home#main', as: 'homepage'
  devise_for  :users,
              controllers:  { registrations: 'registrations' },
              path_names:   {
                              sign_in:  'login',
                              sign_up:  'signup',
                              sign_out: 'logout'
                            }
  resources :users, only: :show do
    resources :announcements, only: [:index, :show]
  end
  resources :announcements, only: [:new, :create, :edit, :update, :destroy]
end
