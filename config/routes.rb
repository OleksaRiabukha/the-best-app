Rails.application.routes.draw do
  devise_for :users

  resources :users

  resources :restaurants

  namespace :admin do
    get '/dashboard', to: "dashboard#index"
    resources :restaurants
  end

  root 'home#index'
end
