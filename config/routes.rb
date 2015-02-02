Rails.application.routes.draw do

  root 'static_pages#home'

  # # Manually setting the root path
  # get '/', to: 'static_pages#home'

  get '/items',     to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/about',     to: 'static_pages#about'
end
