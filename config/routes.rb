Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :posts do
      resources :likes, only: [:create]
      resources :comments, only: [:new, :create]
    end
  end

  delete "/posts/:id", to: "posts#destroy", as: :destroy_post

  root to: "users#index"
end
