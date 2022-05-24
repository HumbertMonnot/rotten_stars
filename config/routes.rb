Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:show] do
    resources :reservations, only: [:index, :edit, :update]
    resources :reviews, only: [:index, :new, :create]
  end
end
