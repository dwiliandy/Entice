Rails.application.routes.draw do

  
#Customer
  root to: 'pages#index'
  get 'about', to: 'pages#about'
  get 'coupons/checking/:code', action: :checking, controller: 'coupons'
  post 'cekstatus', to: 'cart_products#check'

  resource :comments
  resources :users, only: [:edit, :update]
  resources :wallet_statuses
  resources :carts do
    member do
      post 'create_transaction'
      post 'change_quantity'
    end
  end 
  
  resources :orders do
    member do
      patch 'cancel'
    end
  end

  resources :cart_products do
    member do
      post :change_quantity
    end
  end
  
  devise_for :users
  resources :products do
    member do
        post 'add_cart_product'
        post 'create_comment'
      end
    end
  
  


	#ADMIN
	namespace :admins do
		get 'pages/index' => 'pages#index'
		resources :products do
      member do
        post "create_comment"
      end
    end

    resources :orders, except: [:new, :destroy] do
       member do
        get "input_receiver"
        get "input_receipt" 
        patch "transition"
      end
    end

		resources :coupons
    resources :postal_fees 
    resources :wallet_statuses, except: [:new, :destroy, :show]
	end
  end
