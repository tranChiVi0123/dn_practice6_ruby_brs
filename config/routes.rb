Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    root "reviews#index"
    namespace :admin do
      resources :users, except: [:new, :show]
      resources :books
    end
    get "home", to: "reviews#index"
    get "signup", to: "admin/users#new"
    get "signin", to: "sessions#new"
    post "signin", to: "sessions#create"
    delete "signout", to: "sessions#destroy"
  end
end
