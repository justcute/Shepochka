Rails.application.routes.draw do
  resources :products
  devise_for :users
  root 'static_pages#index'
  resources :users
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  get '/products/sort/rating', to: 'products#index_rating_sort', as: 'rating_products'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
