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
  end
  resources :posts, only: :show do
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: :show do
    resources :replies, only: [:new, :create]
  end
end
