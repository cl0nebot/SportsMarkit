Rails.application.routes.draw do
    root 'main#index'
    
    resources :users do
      resources :events
      resource :calendar do
        get :events, on: :member
      end
    end
    resources :events
    resources :sessions
    resources :password_resets
    resources :schools do
      resources :facilities
      resources :teams
    end
    
    resources :teams do
      resources :events
      resource :calendar do
        get :events, on: :member
      end
      member do
        patch :accept_user
        post :add_facility
      end
    end
    resources :facilities
    resources :leagues 
    resources :fans
    resources :attendees
    resources :relationships
    resources :sitemap
    resources :sports
    resources :certifications
    resources :team_facilities
    
    get 'auth/:provider/callback', to: "omniauth_callbacks#facebook"
    get 'auth/failure', to: redirect('/')
    
    get "login" => "sessions#new", as: :login
    get "signup" => "users#new", as: :signup
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
