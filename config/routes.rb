Rails.application.routes.draw do


  root to: "sessions#new"
  resources :links,     only: [:index, :create, :destroy, :update]
  resources :sessions,  only: [:new, :create, :destroy]
  resources :users,     only: [:new, :create]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
