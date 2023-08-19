Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  root'home#index'
 
  post '/login'=> 'sessions#login'
  delete '/logout'=> 'sessions#logout'
  get '/logged_in'=> 'sessions#logged_in'
  get '/csrf-token' => 'sessions#csrf_token'

  get '/signup'=>'users#new'
  post'/signup'=>'users#signup'
  get 'users/:id/edit'=> 'users#edit'
  patch 'users/:id/update'=>'users#update'
  get 'users/:id'=>'users#show'
  
  get 'posts/index'=>'posts#index'
  get 'posts/new'=>'posts#new'
  get 'posts/:user_id/edit'=> 'posts#edit'
  get 'posts/:user_id/show'=> 'posts#show'
  post 'posts/create'=>'posts#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
