Rails.application.routes.draw do

  devise_for :users

  root to: "home#index"
  post :search, to: "home#search"

  resources :users, only: [:show] do
    resources :tweets, only: [:create, :destroy] do
      member do
        post :retweet, :unretweet
      end
    end

    resources :likes, only: [:index, :create, :destroy]
    resources :followings, only: [:index, :create, :destroy]
    resource :profile, only: [:edit, :create, :update]
  end

  resources :dms, only: [:index, :show, :new, :create] do
    member do
      post :add_message
    end
    collection do
      get :select_users
      post :submit_users
    end
  end

  # ヘルパーの名前をfollowingsと同じようにして、actionをfollowingsと同じコントローラに入れるためにはmatchを使うしかなかった
  match "users/:user_id/followers", to: 'followings#followers_index', via: :get, as: :user_followers
end
