Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:show, :index, :new, :create]
  resources :orders, only: [:new, :create, :show, :index, :edit, :update] do
    get 'search', on: :collection
    member do
      post 'delivered'
      post 'canceled'
    end
  end
end
