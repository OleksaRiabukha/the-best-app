Rails.application.routes.draw do
  devise_for :users

  resources :users
  
  namespace :admin do
    get '/dashboard', to: "dashboard#index"
  end

  root 'home#index'
end
