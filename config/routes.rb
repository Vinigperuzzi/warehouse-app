Rails.application.routes.draw do
  root to: "home#index"
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:show, :index, :new, :create]
end
