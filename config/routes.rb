Rails.application.routes.draw do

  
#Customer
  root to: 'pages#index'
  get 'about', to: 'pages#about'
  get 'coupons/checking/:code', action: :checking, controller: 'coupons'
  post 'cekstatus', to: 'cart_products#check'

  resource :comments
  # resources :users, only: [:edit, :update]
  resources :users, only: :index do
    collection do
      get 'profile'
      put 'update'
    end
  end

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
      patch "transition"
    end
  end

  resources :cart_products do
    member do
      post :change_quantity
    end
  end
  
  resources :notifications, only: [:index]

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
        patch 'set_active'
        patch 'set_deactive'
      end
    end

    resources :orders, except: [:new, :destroy] do
       member do
        get "input_receiver"
        get "input_receipt" 
        patch "transition"
      end
    end
    resources :notifications, only: [:index, :show]
    resources :extra_charges, only: [:edit, :update]

		resources :coupons
    resources :service_charges 
    resources :wallet_statuses, only: [:index, :edit, :update] do
      member do 
        patch 'success'
        patch 'failed'
      end
    end
	end
  end
