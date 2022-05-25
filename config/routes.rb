Rails.application.routes.draw do
  devise_for :users

  root to: 'prestations#index'

  resources :prestations, only: [:index, :show] do
    resources :reservations, only: [:create]
  end
  
  resources :reservations, only: [:index] do
    resources :reviews, only: [:new, :create]
  end

  resources :users, only: [:show] do
    resources :prestations, only: [:new, :create, :delete]
    resources :reservations, only: [:index, :edit, :update, :create]
    resources :reviews, only: [:index, :new, :create]
  end
end
