Rails.application.routes.draw do
  devise_for :users

  resources :webhooks, only: [:create]

  get 'successful_checkout', to: 'orders#successful_checkout'

  get 'cancel_checkout', to: 'orders#cancel_checkout'
    
  resources :users do
    resources :orders, except: [:new]
  end

  get '/orders/new', to: 'orders#new'

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
