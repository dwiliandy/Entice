Rails.application.routes.draw do

  root to: 'pages#index'
  get 'about', to: 'pages#about'
  get 'coupons/checking/:code', action: :checking, controller: 'coupons'

  resources :users, only: [:edit, :update]
  resources :carts do
  member do
    post 'create_transaction'
    post 'change_quantity'
  end
end 
  
  resources :transactions do
    member do
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
  resources :cart_products do
    member do
      post :change_quantity
    end
  end
  post 'cekstatus', to: 'cart_products#check'
  resource :comments
	#ADMIN
	namespace :admins do
		get 'pages/index' => 'pages#index'
		resources :products

		resources :transactions do
      get "input_receiver" => 'transactions#input_receiver', :as => :input_receiver
    get "input_receipt" => 'transactions#input_receipt_number', :as => :input_receipt
      member do
        patch 'transition'
      end
    end

		resources :coupons
    resources :postal_fees
    resources :wallets
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
