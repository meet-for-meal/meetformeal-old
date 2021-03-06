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

  resources :users, only: [:index, :show] do
    resources :announcements, only: [:index, :show]
    resources :friendships, only: [:create, :update]
  end

  resources :messages

  # Announcements
  resources :announcements, only: [:new, :create, :edit, :update, :destroy] do
    resources :subscriptions, only: :create
  end
  get '/announcements/near',   to: 'announcements#near',   as: 'near_announcements'
  get '/announcements/search', to: 'announcements#search', as: 'search_announcements'

  # Subscriptions
  get '/subscriptions', to: 'subscriptions#index', as: 'subscriptions'

  # Restaurants
  get '/restaurants', to: 'restaurants#index', as: 'restaurants'
end
