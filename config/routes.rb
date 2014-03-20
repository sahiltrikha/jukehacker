Jukehacker::Application.routes.draw do
  #root page with navbar, products, footer
  root "welcome#index"
  
  #navbar: for hosts logged in, allow them to see their login information
  get "/host/:id", to: "host#show"

  get "partycreate", to: "party#new"

  get "party-dashboard", to: "party#show"

  get "host/:id/party", to: "party#index"
  
  resources :users do 
    resources :hosts
    resources :guests
  end 
  
  resources :songs do 
    resources :played_songs
    resources :queued_songs
  end 


end
