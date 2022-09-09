Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"

  resources :posts do
    resources :comments, shallow: true, only: [:create, :destroy]
  end
  resources :users
  resource :session, only: [:new, :create, :destroy]
end
