Rails.application.routes.draw do
  devise_for :users

  resources :webhooks, only: [:create]

  resources :coupons, only: %i[new create]

  get 'successful_coupon_checkout', to: 'coupons#successful_coupon_checkout'

  get 'cancel_coupon_checkout', to: 'coupons#cancel_coupon_checkout'

  get 'successful_order_checkout', to: 'orders#successful_order_checkout'

  get 'cancel_order_checkout', to: 'orders#cancel_order_checkout'

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
