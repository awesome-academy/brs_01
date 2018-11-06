Rails.application.routes.draw do
  root "home_pages#home"
  get "/help", to: "home_pages#help"
  get "/contact", to: "home_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :books
end
