Rottenpotatoes::Application.routes.draw do
  resources :stores
  # map '/' to be a redirect to '/stores'
  root :to => redirect('/stores')

  get '/stores/:id/similar_stores/category', to:'stores#search_for_same_category', as: 'stores_with_same_category'
end
