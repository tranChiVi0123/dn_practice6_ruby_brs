Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    namespace :admin do
      resources :users, except: [:new, :show]
    end
    get "home", to: "static_pages#home"
    get "signup", to: "admin/users#new"
  end
end
