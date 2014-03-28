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
  post '/queued_songs', to: 'queued_songs#create'
  get '/queueobject', to: 'queued_songs#get_information'
  resources :users 
  resources :hosts
  resources :guests

  resources :songs
  resources :parties
  resources :played_songs
  resources :queued_songs
  resources :sessions
  post "/sessions", to: "sessions#create"


  # # PJ: Below is a suggeseted direction for your routes, to make them fit a more 
  # # RESTful convention. For more, see: http://guides.rubyonrails.org/routing.html
  # root "welcome#index"
  # resource :session, only: [:new, :create, :destroy] # singular resource

  # # first off, guest and host should both be "types" of Users...
  # # see: http://api.rubyonrails.org/classes/ActiveRecord/Base.html#label-Single+table+inheritance
  # resources :users do
  #   # as a host, you can create, destroy and list your parties,
  #   # but once a party is created, you interact with it directly
  #   # thus shallow -- but since it's complicated we won't use the 
  #   # shallow: true shorthand (which does exactly what you see below)
  #   resources :parties, only: [:new, :create, :index] do
  #   end
  # end

  # resources :parties, only: [:show, :edit, :update, :destroy] do
  #   # there should be a single song class, with a played boolean, or a place-in-the-queue value
  #   # users can then either create the song (enqueue), upvote or downvote, read, etc.
  #   resources :songs, except: [:new] do 
  #     member do        # one route for each song...
  #       put "upvote"   # these could be done with a song#update, but this is more semantic
  #       put "downvote" # it's up to you... i'd just have these redirect to #update
  #     end

  #     collection do  # one route for 'all' the songs... (more semantic endpoints)
  #       get "queued" # #index where not played
  #       get "played" # #index where played
  #       get "next"   # #show where next
  #     end
  #   end

  #   resources :rules # not sure how this works
  # end

  # # if you want a single api endpoint for your sms calls, that's fine,
  # # but then you should just have it be a series of if/elses and redirects
  # get "sms", to: "sms#redirect"

end
