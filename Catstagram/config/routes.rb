Rails.application.routes.draw do
  resources :roles
  devise_for :users
  resources :hashtags
  resources :photos
  resources :cats
  resources :users do 
    member do 
      put :save_roles
      get :edit_roles
    end
  end

  # get the ban form / update the ban status of a user
  get 'users/:id/ban', to: 'users#ban', as:'ban_user'
  put 'users/:id/ban', to: 'users#ban_update', as:'ban_update_user'
  patch 'users/:id/ban' => 'users#ban_update'
  post 'users/:id/ban' => 'users#ban_update'

  # used to show specific section of a user (cats ot photos)
  # doesn't work properly as '#' is replaced by '%25' and doesn't work anymore
  get 'users/:id#:sect', to: 'users#show', as: 'user_show_section'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  # destination of / and index_path
  root to: 'photos#index', as: 'index'

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
