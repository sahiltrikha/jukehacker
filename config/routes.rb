Jukehacker::Application.routes.draw do
  #root page with navbar, products, footer
  root "welcome#index"
  
  #navbar: for hosts logged in, allow them to see their login information
  get "/host/:id", to: "host#show"

  get "partycreate", to: "party#new"

  get "party-dashboard", to: "party#show"

  get "host/:id/party", to: "party#index"

  get '/sms', to: 'sms#index'
  
  resources :users 
  resources :hosts
  resources :guests

  resources :songs
  resources :parties
  resources :played_songs
  resources :queued_songs



end
