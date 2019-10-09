Rails.application.routes.draw do
  resources :riders, only: [:create, :destroy]
  resources :messages
  resources :events
  resources :reports
  resources :trips
  resources :plans
resources :vehicles

  get '/messages/trip/:trip_id', to: 'messages#for_single_trip'
  get '/users/profile',          to: 'profiles#index',    as: :profile
  get '/users/settings',         to: 'profiles#settings', as: :settings

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
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
