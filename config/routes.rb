Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :posts do
      resources :likes, only: [:create]
      resources :comments, only: [:new, :create]
    end
  end

  root to: "users#index"
end
