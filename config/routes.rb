Rails.application.routes.draw do
  
  root to: 'pages#index'
  resources :coupons do 
    collection do 
      get 'checking/:code', action: :checking
    end
  end
  resources :carts do
  member do
    post 'create_transaction'
  end
end 
  resources :transactions
  devise_for :users
  resources :products do
    member do
        post 'add_cart_product'
      end
    end
  resources :cart_products 
  post 'cekstatus', to: 'cart_products#check'

	#ADMIN
	namespace :admins do
		get 'pages/index' => 'pages#index'
		resources :products
		resources :transactions
		resources :coupons
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
