Rails.application.routes.draw do
  devise_for :users
  root to: 'prestations#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :prestations, only: [:index, :show]
  resources :users do
    resources :prestations, only: [:new, :create, :delete]
  end
end
