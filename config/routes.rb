Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :users do
    resources :posts do
      resources :likes, only: [:create]
      resources :comments, only: [:new, :create]
    end
  end
end
