Rails.application.routes.draw do
  
  root to: 'pages#index'
  get 'about', to: 'pages#about'
  
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
  resources :transactions do
    member do
      patch 'transition'
      patch 'cancel'
    end
  end
  devise_for :users
  resources :products do
    member do
        post 'add_cart_product'
        post 'create_comment'
      end
    end
  resources :cart_products 
  post 'cekstatus', to: 'cart_products#check'
  resource :conversations
	#ADMIN
	namespace :admins do
		get 'pages/index' => 'pages#index'
		resources :products
		resources :transactions
		resources :coupons
    resources :postal_fees
    resources :wallets
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
