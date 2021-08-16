Rails.application.routes.draw do
  devise_for :users

  resources :users

  resources :restaurants, only: %i[index show]

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'

    resources :restaurants, :categories
  end

  root 'home#index'
end
