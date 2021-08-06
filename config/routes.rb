Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :users

  resources :restaurants

  namespace :admin do
    get '/dashboard', to: "dashboard#index"
    resources :restaurants
  end
end
