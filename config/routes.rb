Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  resources :users, only: %i[edit update]

  get "users/search", to: "users#search"

  resources :articles do
    resources :comments
  end
end
