Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  root "posts#index"

  get 'about' => 'pages#about'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :account_activations, only: [:edit]
  resources :users
  resources :posts do
    resources :comments do 
      resources :comment_likes
    end
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
end
