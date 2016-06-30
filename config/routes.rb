Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get "/auth/facebook", as: :sign_in_with_facebook
  get "/auth/facebook/callback" => "callbacks#facebook"
  get "/auth/google_oauth2", as: :sign_in_with_google
  get "/auth/google_oauth2/callback" => "callbacks#google_oauth2"
  get "/auth/twitter", as: :sign_in_with_twitter
  get "/auth/twitter/callback" => "callbacks#twitter"
  scope module: 'users' do
    # resources :password_changes, only: [:edit, :update]
    resources :account_verifications, only: [:new, :create, :edit]
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :posts
    end
  end

  resources :password_resets, only: [:new, :create, :edit, :update]

  root "home#home", as: :home
  get "/home" => "home#home"
  get "/about" => "home#about", as: :about_us

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :users, only: [:new, :create, :edit, :update, :delete]
  resources :posts do

    resources :favourites, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :destroy, :update]
  end

  resources :favourites, only: [:index]

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
