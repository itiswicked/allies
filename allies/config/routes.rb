Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show]
  resources :ratings, only: [:new, :create]
  resources :organizations
  resources :requests, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :incidents
      resources :allies
    end
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
