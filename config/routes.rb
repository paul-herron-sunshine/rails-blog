Rails.application.routes.draw do

  root "posts#index"

  get 'about' => 'pages#about'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  # Resources
  resources :users
  resources :posts do 
    resources :comments
  end

end
