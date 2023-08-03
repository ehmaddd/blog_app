Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :posts do
      resources :likes, only: [:create]
      resources :comments, only: [:new, :create]
    end
  end

  delete "/posts/:id", to: "posts#destroy", as: :destroy_post
  delete "/posts/:post_id/comments/:id", to: "comments#destroy", as: :destroy_comment

  root to: "users#index"
end
