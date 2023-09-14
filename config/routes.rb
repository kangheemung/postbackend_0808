Rails.application.routes.draw do
  root'home#index'

  post 'login'=> 'sessions#login'
  delete '/logout'=> 'sessions#destroy'
  get '/logged_in'=> 'sessions#logged_in'
 
  post'/signup'=>'users#signup'
  get 'users/:id/edit'=> 'users#edit'
  patch 'users/:id/update'=>'users#update'
  get 'mypage'=>'users#show'
  
  get 'posts/index'=>'posts#index'
  get 'posts/new'=>'posts#new'
  get 'posts/:user_id/edit'=> 'posts#edit'
  get 'posts/:user_id/show'=> 'posts#show'
  post 'posts/create'=>'posts#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
  