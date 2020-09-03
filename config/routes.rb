Rails.application.routes.draw do
  get 'cards/new'
  root 'items#index'
  post 'items/commission', to: 'items#commission'
  post 'items/profit', to: 'items#profit'
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'personals', to: 'users/registrations#new_personal'
    post 'personals', to: 'users/registrations#create_personal'
  end

  resources :items do
    resources :purchases, only: [:index, :create]
    resources :likes, only: [:create, :destroy]
  end
  resources :cards, only: [:new, :create, :destroy]
end
