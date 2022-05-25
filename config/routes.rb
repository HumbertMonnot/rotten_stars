Rails.application.routes.draw do
  devise_for :users
  root to: 'prestations#index'

  resources :prestations, only: [:index, :show, :new, :destroy, :create] do
    resources :reservations, only: [:create]
  end
  
  resources :reservations, only: [:index] do
    resources :reviews, only: [:new, :create]
  end

  resources :users, only: [:show] do
    resources :reservations, only: [:index, :edit, :update, :create]
    resources :reviews, only: [:index, :new, :create]
    resources :prestations, only: [:new, :destroy, :create]
  end
end
