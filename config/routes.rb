Rails.application.routes.draw do
  resources :products
  devise_for :users
  root 'static_pages#index'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
