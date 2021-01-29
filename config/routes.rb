Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      resources :users, except: [:new, :show]
    end
    get "signup", to: "admin/users#new"
    get "signin", to: "sessions#new"
    get "signout", to: "session#destroy"
  end
end
