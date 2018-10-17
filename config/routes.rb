Rails.application.routes.draw do
  root "posts#index"

  get 'about' => 'pages#about'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'


  resources :users
  resources :posts

end
