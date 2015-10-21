Rails.application.routes.draw do
  
  root :to => 'users#news'

  resources :comments
  resources :statuses
  resources :users
  
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/usernews' => 'users#news' , as: :user_news

  get '/userwall/:id' => 'users#wall' , as: :user_wall

  post '/postcomment/:id' => 'comments#post', as: :post_comment

  post '/poststatus/:id' => 'statuses#post', as: :post_status

  post '/befriend/:id' => 'users#befriend', as: :befriend

  post '/unfriend/:id' => 'users#unfriend', as: :unfriend

  get '/search' => 'users#search'

  post '/like/:id' => 'statuses#like', as: :like

  post '/dislike/:id' => 'statuses#dislike', as: :dislike

  get  '/photos/:id' => 'photos#index', as: :photos

end
