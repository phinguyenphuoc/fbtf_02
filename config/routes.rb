Rails.application.routes.draw do
  root "static_pages#home"

  get "/index", to: "travellings#index"
  get "/show", to: "travellings#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  namespace :admin do
    root "static_pages#show"
    get "/locations", to: "locations#index"
    post "/locations", to: "locations#create"
    resources :users, only: %i(index destroy)
    resources :locations, except: :show
    resources :travellings, except: :show
    resources :tours, except: :show
  end
  resources :users
  resources :travellings
  resources :tours
  resources :reviews

  delete "/unlike", to: "likes#destroy"
  resources :likes
end
