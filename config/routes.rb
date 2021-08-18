Rails.application.routes.draw do
  devise_for :users

  resources :users, :restaurants

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'

    resources :restaurants do
      resources :menu_items, except: %i[index]
    end
  end

  root 'home#index'
end
