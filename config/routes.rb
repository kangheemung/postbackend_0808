Rails.application.routes.draw do
  post '/login'=> 'sessions#login'
  delete '/logout'=> 'sessions#logout'
  get '/logged_in'=> 'sessions#logged_in?'

  get 'users/new'
  post'/signin'=>'users#create'
  get 'users/show'
  get 'users/edit'
  get 'posts/index'=>'posts#index'
  get 'posts/new'=>'posts#new'
  get 'posts/edit'
  get 'posts/show'
  post 'posts/create'=>'posts#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
