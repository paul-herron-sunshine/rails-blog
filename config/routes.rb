Rails.application.routes.draw do

  root "posts#index"

  # get 'home', to: 'static_pages#home'
  get 'about' => 'pages#about'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  resources :users
  resources :posts

end
