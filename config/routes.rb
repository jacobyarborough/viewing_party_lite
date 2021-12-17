Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'landing#index'

  # Users Controller
  get '/register', to: 'users#new', as: 'register'
  post '/register', to: 'users#create'
  get '/dashboard', to: 'users#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy'

  get '/discover', to: 'movies#discover'
  get '/movies', to: 'movies#index', as: "user_movies"
  get '/movies/:movie_id', to: 'movies#show'

  # Parties Controller
  get '/movies/:movie_id/party/new', to: 'parties#new'
  post '/movies/:movie_id/party/new', to: 'parties#create'
end