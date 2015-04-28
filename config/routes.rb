Rails.application.routes.draw do

  root 'pages#home'
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :envios, :only => [:create, :destroy]

  get 'pages/home' 
  get '/signup', :to => 'users#new'
  get '/signin', :to => 'sessions#new'
  get '/signout', :to => 'sessions#destroy'
  
end
