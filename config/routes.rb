Rails.application.routes.draw do
  devise_for :users

  resources :users

  resources :restaurants, only: %i[index show]

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'

    resources :categories

    resources :restaurants do
      resources :menu_items, except: %i[index]
    end
  end

  root 'home#index'
end
