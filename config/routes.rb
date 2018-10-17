Rails.application.routes.draw do

  get 'comments/new'
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'

  root "posts#index"

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'


  resources :users
  resources :posts
  resources :comments

end
