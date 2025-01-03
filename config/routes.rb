# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "articles#index"

  resources :users, only: %i[edit update index] do
    collection do
      get :friends
    end
  end

  resources :articles do
    resources :comments
  end

  resources :friendships, only: %i[create update destroy] do
    collection do
      get :incoming_requests
      get :sent_requests
    end
  end

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
# rubocop:enable Metrics/BlockLength
