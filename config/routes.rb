Rails.application.routes.draw do

  root "posts#index"
  get 'about' => 'pages#about'

#  get '/signup', to: 'users#new'

  resources :users
  resources :posts

end
