Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root 'items#index'
  post 'items/commission', to: 'items#commission'
  post 'items/profit', to: 'items#profit'

  resources :items do
    resources :purchases, only: [:index, :create]
  end
  resources :cards, only: [:new, :create, :destroy]
end
