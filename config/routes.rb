Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_page#home'
  get '/signup', to:'users#new'
  post '/signup', to:'users#create'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  get '/logout', to:'sessions#destroy'

  resources :users do
    resources :posts, only: [:index, :new, :create]
    resources :book_marks, only: :index
    resources :relationships, only: [:create, :destroy]
    resources :followings, only: :index, module: :users
    resources :followers, only: :index, module: :users
    resources :messages, only: [:index, :create, :show]
    resources :drafts, only: :index, module: :posts
  end

  resources :posts, only: :show do
    resources :comments, only: [:new, :create]
    resources :book_marks, only: [:create, :destroy]
    resources :reposts, only: [:new, :create], module: :posts
  end

  resources :comments, only: :show do
    resources :replies, only: [:new, :create]
  end

  resources :search_users, only: :index, module: :users
  resources :search_posts, only: :index, module: :posts
  resources :drafts, only: [:edit, :update], module: :posts
end
