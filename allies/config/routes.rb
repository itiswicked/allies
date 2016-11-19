Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users
  resources :organizations

  root "/users/sign_up" 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
