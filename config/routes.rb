Rails.application.routes.draw do
  # Admin routes
  namespace :admin do
    resources :payments, only: [ :index, :show ]
  end

  # Devise routes for user authentication with custom registration controller
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  # Payment routes
  resources :payments, only: [ :new, :create ]

  # Photo routes
  resources :photos

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Main application routes
  root "welcome#index"
end
