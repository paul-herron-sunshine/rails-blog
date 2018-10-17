Rails.application.routes.draw do

<<<<<<< HEAD
  get 'comments/new'
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
=======
  root "posts#index"
>>>>>>> 383f792b941ee0e060cf1a985eef30f53e8902b1

  # get 'home', to: 'static_pages#home'
  get 'about' => 'pages#about'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  resources :users
  resources :posts

end
