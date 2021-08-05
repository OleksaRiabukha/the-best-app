Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, :controllers => { registrations: 'devise/registrations' }
  resources :users
  namespace :admin do
    get '/dashboard', to: "dashboard#index"
  end
end
