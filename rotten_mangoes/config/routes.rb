Rails.application.routes.draw do

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
    resources :users do
      collection do
        put :switch_back
      end
      member do # => be able to switch to invididual member or resources (which is a user in users)
        put :switch # => see switch definition in Admin::UsersController
        # put :switch_back
      end
    end
  end


  # => another way to define the namespace
  # scope :admin, module: :admin, as: :admin do
  #   resources :users
  # end 


  root to: 'movies#index'

end
