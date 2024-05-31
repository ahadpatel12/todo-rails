Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :clients, defaults: {format: :json}


  mount ActionCable.server => "/cable"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # authentication
  post '/register', to: 'authentication#register'
  post '/login' , to: 'authentication#login'

  # user routes
  get '/users' , to: 'users#list'
  patch '/users' , to: 'users#update'
  delete '/user/:id' , to: 'users#destroy'

  # todo routes
  post '/todo', to: 'todo#create'
  get '/todos', to: 'todo#list'
  patch '/todo/:id', to: 'todo#edit'
  delete '/todo/:id', to: 'todo#destroy'

  # Defines the root path route ("/")
  # root "posts#index"
end

# == Route Map
#
