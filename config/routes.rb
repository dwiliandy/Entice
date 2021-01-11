Rails.application.routes.draw do
  
  resources :carts do
  	member do
  		post 'create_cart_product'
  	end
  end
  resources :transactions
  devise_for :users
	root to: 'pages#index'
  resources :products
  resources :cart_products

	#ADMIN
	namespace :admins do
		get 'pages/index' => 'pages#index'
		resources :products
		resources :transactions
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
