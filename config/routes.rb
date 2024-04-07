Rails.application.routes.draw do
  root to: "home#index"
  resources :warehouses, only: [:show, :new, :create]
end
