PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :posts do
  	member do
  		post 'vote'
  	end
  	resources :comments, only: [:create, :vote] do
  		member do
  			post 'vote'
  		end
  	end
  end
  resources :users
  resources :categories, only: [:new, :create, :show]
end
