Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show] do
    member do
      get :past_reservations
    end
    resources :reservations, only: [:index, :edit, :update]
    resources :reviews, only: [:index, :new, :create]
    resources :prestations, only: [:index]
  end
end
