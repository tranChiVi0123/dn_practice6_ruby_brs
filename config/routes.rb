Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  scope "(:locale)", locale: /en|vi/ do
    root "reviews#index"
    namespace :admin do
      resources :users, except: [:new, :show]
      resources :books
      resources :responses do
        collection do
          post :accept
        end
      end
    end
    resources :reviews, except: [:index]
    resources :books
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :requests do
      collection do
        post :seen
      end
    end
    post "comment", to: "reviews#comment"
    post "reply", to: "reviews#reply"
    get "signup", to: "admin/users#new"
    get "signin", to: "sessions#new"
    post "signin", to: "sessions#create"
    delete "signout", to: "sessions#destroy"
  end
end
