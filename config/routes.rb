Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies do
    resources :reviews, only: [:new, :create]
    collection do
      get 'new_search'
      get 'search_results'
    end
  end
  
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  
  namespace :admin do
    resources :users
    # resources :sessions, only: [:new, :create, :destroy]
    # resources :movies do
    #   resources :reviews, only: [:new, :create]
    # end
  end

  root to: 'movies#index'
  
end
