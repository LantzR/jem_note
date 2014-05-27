Rails.application.routes.draw do


  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - Override routes for name
  get    'jems(.:format)'            => 'jems#index'
  post   'jems(.:format)'            => 'jems#create'
  get    'jems/new(.:format)'        => 'jems#new'
  
  get    'jems/:name/edit(.:format)' => 'jems#edit'
  get    'jems/:name(.:format)'      => 'jems#show'
  patch  'jems/:name(.:format)'      => 'jems#update'
  put    'jems/:name(.:format)'      => 'jems#update'
  delete 'jems/:name(.:format)'      => 'jems#destroy'

  # - - - - - - - - - - - - - - - - - - - - - - - -
  # Default 7 routes
  #     jems GET    /jems(.:format)          jems#index
  #          POST   /jems(.:format)          jems#create
  #  new_jem GET    /jems/new(.:format)      jems#new

  # edit_jem GET    /jems/:id/edit(.:format) jems#edit
  #      jem GET    /jems/:id(.:format)      jems#show
  #          PATCH  /jems/:id(.:format)      jems#update
  #          PUT    /jems/:id(.:format)      jems#update
  #          DELETE /jems/:id(.:format)      jems#destroy

  #resources :jems
  # - - - - - - - - - - - - - - - - - - - - - - - -

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
