Rails.application.routes.draw do

  root to: "sessions#new"
  resources :links,     only: [:index, :create, :edit, :update]
  resources :sessions,  only: [:new, :create, :destroy]
  resources :users,     only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :links,     only: [:index, :update]
    end
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
