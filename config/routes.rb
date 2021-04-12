Rottenpotatoes::Application.routes.draw do
    
  resources :users, only: [:new, :create]

  get 'login', to: 'sessions#new'
    
  post 'login', to: 'sessions#create'
    
  delete 'logout', to: 'sessions#destroy'

  get 'welcome', to: 'sessions#welcome', as: 'welcome'
    
  get 'authorized', to: 'sessions#page_requires_login'

  resources :stores
  # map '/' to be a redirect to '/stores'
  root :to => redirect('/stores')

  get '/stores/orders/:id', to: 'stores#orders', as: 'orders'
    
  get '/stores/my_orders/:id', to: 'stores#my_orders', as: 'my_orders'
    
  get '/stores/:id/similar_stores/category', to:'stores#search_for_same_category', as: 'stores_with_same_category'

end
