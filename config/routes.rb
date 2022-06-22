Rails.application.routes.draw do
  get 'ideas/index'
  get 'ideas/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :ideas, only: [:index, :create]

  # Defines the root path route ("/")
  # root "articles#index"
end
