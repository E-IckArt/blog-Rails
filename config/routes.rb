Rails.application.routes.draw do
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/articles", to: "articles#index"
  # get 'home/index', to: "home#index"
  #
  # Defines the root path route ("/")
  root "home#index"
end
