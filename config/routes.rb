Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'users/auth/facebook/callback',    to: 'users#facebook_login',      as: :auth_callback
  get '/auth/failure',                   to: 'users#auth_failure',        as: :auth_failure
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :microposts,    only: [:index, :show, :new, :create, :destroy] do
    resources :comments, only: [:create]
    post 'add' => 'likes#create'
    delete '/add' => 'likes#destroy'
  end
  resources :notifications, only: [:index, :destroy]
end
