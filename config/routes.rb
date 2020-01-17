Rails.application.routes.draw do
  resources :car_makes
  resources :categories
  resources :leads, only: [:create]
  resources :riders, only: [:create, :destroy]
  resources :messages, only: [:create, :index]
  resources :events
  resources :reports
  resources :trips
  resources :plans
  resources :vehicles

  get '/messages/trip/:trip_id',  to: 'messages#for_single_trip'
  get '/users/profile',           to: 'profiles#index',           as: :profile
  get '/users/settings',          to: 'profiles#settings',        as: :settings
  get '/leads/trip/:trip_id',     to: 'leads#for_single_trip',    as: :leads_for_trip
  get '/trips/search/any-trip',   to: 'trips#search',             as: :trips_search
  get '/home/load_more',          to: 'pages#home'
  get '/messages/users.csv',      to: 'messages#export_users_csv', as: :export_users_csv

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
    # sessions: 'users/sessions',
    # passwords: 'users/passwords',
    # registrations: 'users/registrations',
    # confirmations: 'users/confirmations'
  }

  root to: 'pages#home'

  # namespace :api, defaults: { format: :json } do
  #   namespace :v1 do
  #     mount_devise_token_auth_for "User", at: "auth",
  #       controllers: {
  #         sessions: 'api/v1/devise_token_auth/sessions'
  #       }
  #     resources :appointments, only: [ :index, :show, :create, :update, :destroy ]
  #   end
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
