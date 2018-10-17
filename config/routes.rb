Rails.application.routes.draw do

  get 'comments/new'
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'

  root "posts#index"

  # get 'home', to: 'static_pages#home'
  get 'about' => 'pages#about'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  resources :users
  resources :posts
  resources :comments

end
