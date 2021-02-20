Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount ActionCable.server => "/cable"
  scope "(:locale)", locale: /en|vi/ do
    root "reviews#index"
    namespace :admin do
      resources :users, except: [:new, :show]
      resources :books
    end

    resources :reviews, except: [:index]
    resources :books
    resources :users do
      member do
        get :following, :followers
      end
    end

    post "comment", to: "reviews#comment"
    post "reply", to: "reviews#reply"
    get "signup", to: "admin/users#new"
    get "signin", to: "sessions#new"
    post "signin", to: "sessions#create"
    delete "signout", to: "sessions#destroy"
    resources :relationships, only: [:create, :destroy]
  end
end
