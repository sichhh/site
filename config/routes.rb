Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  resources :users, only: %i[edit update]

  resources :articles do
    resources :comments
  end
end
