Rails.application.routes.draw do
  resources :rankings
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "api/v1/users", to: "users#create"

  post "api/v1/users/login", to: "users#login"

  post "api/v1/ranking/record" , to: "rankings#create"

  get "api/v1/ranking/:anio/:mes", to: "rankings#period"

  get "api/v1/ranking/actual", to: "rankings#current"



end
