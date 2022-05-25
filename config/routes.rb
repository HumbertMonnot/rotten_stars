Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:show] do
    resources :reservations, only: [:index, :edit, :update]
  end
  resources :reservations, only: [:index] do
    resources :reviews, only: [:new, :create]
  end
end
