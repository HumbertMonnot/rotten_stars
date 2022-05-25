Rails.application.routes.draw do
  devise_for :users
  root to: 'prestations#index'

  resources :prestations, only: [:new, :destroy, :create]

  resources :users, only: :show do
    resources :reservations, only: [:index, :edit, :update]
    resources :reviews, only: [:index, :new, :create]
    resources :prestations, only: [:new, :destroy, :create]
  end
end
