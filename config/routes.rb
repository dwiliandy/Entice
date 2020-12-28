Rails.application.routes.draw do
  resources :transactions
  devise_for :users
  	root to: 'pages#index'


	#ADMIN
	namespace :admins do
		get 'pages/index' => 'pages#index'
		resources :products
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
