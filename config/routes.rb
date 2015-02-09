Rails.application.routes.draw do

  root 'static_pages#home'

  # # Manually setting the root path
  # get '/', to: 'static_pages#home', as: 'root'

  # get '/items',     to: 'items#index'
  # # Visiting /items/2  aka seeing the details of the item with id == 2
  # get '/items/:id', to: 'items#show',         as: 'item'
  # resources :items, only: [:index, :show, :new, :create]
  resources :items,  except: [:edit, :update, :destroy]
  get '/about',     to: 'static_pages#about'
end
