Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "posts#index"
  get 'root', to: 'posts#index'

  resources :posts
  resources :comments, only: [:create, :destroy]
end
