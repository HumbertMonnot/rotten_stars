Rails.application.routes.draw do
  devise_for :users
<<<<<<< HEAD
  root to: 'prestations#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :prestations, only: [:index, :show]
  resources :users do
    resources :prestations, only: [:new, :create, :delete]
=======
  root to: 'pages#home'
  resources :users, only: [:show] do
    resources :reservations, only: [:index, :edit, :update]
    resources :reviews, only: [:index, :new, :create]
>>>>>>> master
  end
end
