Rails.application.routes.draw do
  
  resources :carts
  resources :transactions
  devise_for :users
	root to: 'pages#index'
  resources :products do
    member do
        post 'add_cart_product'
      end
    end
  resources :cart_products
  post 'add_product_cart', to: 'products#check'

	#ADMIN
	namespace :admins do
		get 'pages/index' => 'pages#index'
		resources :products
		resources :transactions
		resources :coupons
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
