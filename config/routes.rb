Rails.application.routes.draw do

  root 'static_pages#home'

  # # Manually setting the root path
  # get '/', to: 'static_pages#home'

  get '/items',     to: 'items#index'
  # Visiting /items/2  aka seeing the details of the item with id == 2
  get '/items/:id', to: 'items#show',         as: 'item'
  get '/about',     to: 'static_pages#about'
end
