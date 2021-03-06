Rails.application.routes.draw do
  resources :books
  devise_for :users,  :controllers => { registrations: 'registrations', :omniauth_callbacks => "omniauth" }
  resources :users, only: [:show]
  # Home Page
  root 'stories#index'

  # About Page
  get '/about' => 'welcome#index'

  # Add recommendation
  post '/addrecommendation' => 'books#addRecommendation'
  match '/deleterecommendation' => 'books#deleteRecommendation', :via => :delete, :as => :delete_recommendation

  # Route for Stories
  resources :stories, except: [:index] do
    member do
      post :like
    end
  end

  # Route for Users
  as :users do
    match '/users' => 'users#index', :via => :get, :as => :show_all_users
    match '/dashboard' => 'users#dashboard', :via => :get, :as => :user_dashboard
    match '/deleteaccount' => 'users#destroy', :via => :get, :as => :delete_my_account
    match '/inviteuser' => 'users#create_invitation', :via => :post, :as => :invite_user
  end

  # Route for books
  as :books do
    match '/currentlyreadinglist' => 'books#addToCurrentlyReading', :via => :post, :as => :add_to_currently_reading
    match '/wishlist' => 'books#addToWishList', :via => :post, :as => :add_to_wish_list
    match '/read' => 'books#addToAlreadyRead', :via => :post, :as => :add_to_read
    match '/destroycurrentlyreading/:id' => 'books#destroyCurrentlyReading', :via => :delete, :as => :remove_from_currently_reading
    match '/destroywishlist/:id' => 'books#destroyWishList', :via => :delete, :as => :remove_from_wish_list
    match '/destroyalreadyread/:id' => 'books#destroyAlreadyRead', :via => :delete, :as => :remove_from_already_read
  end




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
