Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  post 'items/commission', to: 'items#commission'
  resources :items, only: [:index, :show, :new, :create] do
    resources :purchases, only: [:create]
  end
  
end
