Rails.application.routes.draw do

  root 'static_pages#home'

  # # Manually setting the root path
  # get '/', to: 'static_pages#home', as: 'root'

  # get '/items',     to: 'items#index'
  # # Visiting /items/2  aka seeing the details of the item with id == 2
  # get '/items/:id', to: 'items#show',         as: 'item'
  # resources :items, only: [:index, :show, :new, :create]
  resources :items
  resources :users,     except: [:new]
  resources :sessions,  only:   [:create]

  get '/about',     to: 'static_pages#about'

  get '/signup',    to: 'users#new'
  get '/signin',    to: 'sessions#new'
  delete '/signout',   to: 'sessions#destroy'
end
