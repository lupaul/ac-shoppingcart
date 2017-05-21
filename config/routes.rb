Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end
  namespace :account do
    resources :orders do
      member do
        post :order_cancel
      end
    end

  end
  resources :items, controller: "cartitems"
  resources :orders do
    member do
      get :pay_with_credit_card
    end
  end
  resources :carts do
    collection do
      post :checkout
      delete :clean
    end
  end
  resources :products do
    member do
      post :add_to_cart
    end
  end
end
