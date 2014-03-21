Farmland::Application.routes.draw do

  get "about", :to => "static_pages#about", as: 'about'
  get "help", :to => "static_pages#help", as: 'help'

  get "products/push", :to => "products#push", as: "push"
  resources :products
  resources :orders
  resources :carts, :only => [:show, :destroy]
  resources :line_items, :only => [:create, :destroy]

  get 'managment', :to => "admins#managment", as: "managment"
  get 'managment/products', :to => "admins#products", as: "managment_products"
  get 'managment/users', :to => "admins#users", as: "managment_users"
  get 'managment/orders', :to => "admins#orders", as: "managment_orders"
  post 'managment/order/next_status', :to => "admins#next_status", as: "next_status"
  post 'managment/user/mod_admin', :to => "admins#mod_user_admin", as: "admin_mod"
  post 'managment/user/lock_user', :to => "admins#mod_user_lock", as: "lock_mod"
  get 'managment/user/profile', :to => "admins#show", as: "admin_profile"  

  devise_for :users, :controllers => { :registrations => "users" }
  devise_scope :user do 
    get "users/profile", :to => "users#show", as: 'profile'
    delete "users/delete_account", :to => "users#delete_account", as: 'delete_account'
    post "users/add_credit", :to => "users#add_credit", as: 'add_credit'
    get "users/credit", :to => "users#credit", as: 'credit'
    post "users/add_to_wishlist", to: "users#add_to_wishlist", as: "add_to_wishlist"
    get "users/wishlist", :to => "users#wishlist", as: 'wishlist'
    delete "users/delete_to_wishlist", :to => "users#delete_to_wishlist", as: 'delete_to_wishlist'
  end

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'farmland#index'

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
