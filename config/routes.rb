Rails.application.routes.draw do
  devise_for :users

  resources :users

  resources :cart_items

  resources :carts

  resources :restaurants, only: %i[index show] do
    resources :menu_items, only: %i[show]
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'

    resources :categories

    resources :restaurants do
      resources :menu_items, except: %i[index]
    end
  end

  root 'home#index'
end
