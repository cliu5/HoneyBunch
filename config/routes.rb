Rottenpotatoes::Application.routes.draw do
  resources :stores
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/stores')
end
