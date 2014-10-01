Rails.application.routes.draw do

  namespace :admin do
  get 'users/index'
  end

  get 'categories/index'

  get 'categories/show'

  get 'categories/new'

  get 'categories/edit'

	resources :movies do
    resources :reviews, only: [:new, :create]
    resources :categories, only: [:new, :create]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end


  root to: 'movies#index'

end
