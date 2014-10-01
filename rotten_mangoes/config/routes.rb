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
  # resource :user, only: [:new, :create, :show]
  # resources :users, only: [:new, :create, :show]
  # => if you use user and userS, this is an example of singular routes. 
  # => This is useful when you do no need to show users/:id in url
  # => if you rake routes, you get:
  #     user POST   /user(.:format)                    users#create
  # new_user GET    /user/new(.:format)                users#new
  #          GET    /user(.:format)                    users#show
  #    users POST   /users(.:format)                   users#create
  #          GET    /users/new(.:format)               users#new
  #          GET    /users/:id(.:format)               users#show
  # => see the difference between user#show and users#show ... there is no :id shown

  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end


  root to: 'movies#index'

end
