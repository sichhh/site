Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "articles#index"

  resources :users, only: %i[edit update index]

  resources :articles do
    resources :comments
  end

  resources :friendships, only: %i[index create update destroy]

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create index] do
        member do
          patch :upload_avatar
        end
      end
    end
  end
end
