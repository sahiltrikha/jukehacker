Jukehacker::Application.routes.draw do
  #root page with navbar, products, footer
  root "welcome#index"
  
  #navbar: for hosts logged in, allow them to see their login information
  get "/host/:id", to: "host#show"

  get "partycreate", to: "parties#new"

  get "party-dashboard/:id", to: "parties#show"


  get "host/:id/party", to: "parties#index"

  get '/sms', to: 'sms#req'

  get '/getqueue', to: 'queued_songs#get_queue'
  get '/getnextsong', to: 'queued_songs#get_next_song'
  post '/startsong', to: 'played_songs#create'
  delete '/playingsong', to: 'queued_songs#destroy'

  resources :users 
  resources :hosts
  resources :guests

  resources :songs
  resources :parties
  resources :played_songs
  resources :queued_songs
  post "/sessions", to: "sessions#create"

end
