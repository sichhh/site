Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  resources :users, only: %i[edit update index]

  resources :articles do
    resources :comments
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
