# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }, skip: [:confirmations, :passwords, :unlocks]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'forms#index'
  
  # Protected routes (require authentication)
  authenticated :user do
    resources :forms do
      resources :form_entries, only: [:new, :create, :edit, :update] do
        collection do
          get :csv_export, defaults: { format: :csv }
        end
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
