Rails.application.routes.draw do
  # Admin Dashboard
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # User management
  devise_for  :users,
              controllers:  { registrations: 'registrations' },
              path_names:   {
                              sign_in:  'login',
                              sign_up:  'signup',
                              sign_out: 'logout'
                            }
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  # Homepage
  get '/home', to: 'home#index', as: 'homepage'

  # Public user information
  resources :users, only: :show do
    resources :announcements, only: [:index, :show]
  end

  # Announcements
  resources :announcements, only: [:new, :create, :edit, :update, :destroy]
  get '/announcements/near', to: 'announcements#near', as: 'near_announcements'
end
