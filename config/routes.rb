Rails.application.routes.draw do
    root 'main#home'
        
    resources :users do
      get :email
      get :phone
      resources :photos
      resources :user_profile_pictures, only: %w[create update destroy]
      resources :events do
        collection do
          get :add
          post :create_event
          patch :update_event
        end
        member do
          get :destroy_event
        end
      end
      resource :calendar do
        get :events, on: :member
      end
      resources :measurables
      resources :certificates
      resources :media
    end
    
    resources :chatrooms
    resources :athletic_directors
    
    get "send_certification_reminder" => "notifications#send_certification_reminder", as: :notification_text
    
    get "testsetup" => "setup#testsetup", as: :test_setup
    get "/users/:id/setup" => "setup#setup", as: :user_setup
    get "/users/:id/overview" => "setup#overview", as: :user_overview
    patch "/user/:id/athlete_setup" => "setup#athlete_setup", as: :athlete_setup
    patch "/user/:id/coach_setup" => "setup#coach_setup", as: :coach_setup
    patch "/user/:id/athletic_director_setup" => "setup#athletic_director_setup", as: :athletic_director_setup

    get "welcome" => "users#welcome", as: :user_welcome

    concern :documentable do
      resources :documents, except: %w[destroy show]
      resources :signed_documents, only: %w[index]
    end
    
    concern :announceable do
       resources :announcements
    end

    resources :documents, only: %w[destroy show]
    resources :documents do
      resources :signed_documents, only: %w[new create]
    end
    
    concern :eventable do
      resources :events do
        collection do
          get :add
          post :create_event
          patch :update_event
        end
        member do
          get :destroy_event
        end
      end
    end

    resources :messages do
      collection do
        get :chatroom
        get :events
      end
    end
    resources :measurables do
      get :verify
    end
    resources :certificates
    resources :media
    resources :events do
      get :rsvp
    end
    resources :sessions
    resources :password_resets
    resources :schools, concerns: [:documentable, :announceable, :eventable] do
      resources :forms do
        resources :options
        collection do
          post :create_or_update_form
        end
      end
      resources :facilities
      resources :media
      resources :teams
      resources :photos
      resources :profile_pictures, only: %w[create update destroy]
      resource :calendar do
        get :events, on: :member
      end
      get :upgrade
      get :plan
      patch :upgrade_school
    end
    
    resources :teams, concerns: [:documentable, :announceable, :eventable] do
      resources :forms do
        resources :options
        collection do
          post :create_or_update_form
          
        end
      end
      resources :registrations do
        get :register
      end
      resources :photos
      resources :profile_pictures, only: %w[create update destroy]
      resources :media
      resources :chat
      resource :calendar do
        get :events, on: :member
      end
      member do
        patch :accept_user
        patch :reject_user
        post :add_facility
        post :create_roster_spot
        get :join_league
        get :leave_league
      end
    end

    resources :facilities, concerns: [:documentable, :announceable, :eventable] do
      resources :forms do
        collection do
          post :create_or_update_form
        end
      end
      resources :profile_pictures, only: %w[create update destroy]
      collection do
        get :selection_option
        post :create_from_modal
      end
      resource :calendar do
        get :events, on: :member
      end
      resources :media
      resources :photos
      get :remove_facility
    end

    resources :tournaments
    resources :leagues, concerns: [:documentable, :announceable, :eventable] do
      resources :forms do
        collection do
          post :create_or_update_form
        end
      end
      resources :profile_pictures, only: %w[create update destroy]
      resource :calendar do
        get :events, on: :member
      end
      resources :media
      resources :photos
    end
    resources :fans
    resources :attendees
    resources :relationships
    resources :userless_relationships
    resources :sitemap
    resources :sports
    resources :certifications
    resources :event_types
    resources :positions
    resources :facility_types
    resources :amenities
    resources :facility_links do
      collection do
        post :add_multiple
      end
    end
    resources :pricings do
      get :add_or_update_price
    end
    resources :connects do
      collection do
        post :add_multiple_facilities
      end  
    end
    resources :classifications
    resources :parent_children
    resources :approval do
      get "approval" => "approval#approval", as: :approval
      member do
        patch :approve
      end
    end
    
    resources :uploads do
      collection do
        post :import
        post :roster
      end
    end
    
    resources :clubs, concerns: [:documentable, :announceable, :eventable] do
      resources :forms do
        collection do
          post :create_or_update_form
        end
      end
      resources :facilities
      resources :media
      resources :teams
      resources :photos
      resources :profile_pictures, only: %w[create update destroy]
      resource :calendar do
        get :events, on: :member
      end
      get :upgrade
      get :plan
      patch :upgrade_club
     
    end
    
    resources :forms do
      collection do
        get :change_field
      end
    end
    
    resources :registrations do
      collection do
        get :change_submitter
      end
      patch :pay
    end
    
    resources :rosters do
      get "edit_roster_view" => "rosters#edit_roster_view", as: :edit_roster_view
      get "close_roster_view" => "rosters#close_roster_view", as: :close_roster_view
      get :accept
      get :reject
    end
    
    resources :roles
    get "roleable" => "roles#roleable", as: :roleable
    get "assign" => "roles#assign", as: :assign_role
    post "admin_assign_role" => "roles#admin_assign_role", as: :admin_assign_role
    get "add_role " => "setup#add_role", as: :add_role
    get "delete_role " => "setup#delete_role", as: :delete_role
    
    resources :userless_roles
    
    #contact_messages
    resources :contact_messages
    get "contact" => "contact_messages#new", as: :contact_us
    
    get 'auth/:provider/callback', to: "omniauth_callbacks#facebook"
    get 'auth/failure', to: redirect('/')
    
    get "login" => "sessions#new", as: :login
    get "signup" => "users#new", as: :signup
    
    get "onboard", to: "claims#onboard", as: :partner_signup
    post "onboard", to: "claims#partner_initial_claim", as: :partner_signup_claim
    get "n/leagues/join", to: "claims#join", as: :league_signup
    get "lmanagers", to: "leagues#managers", as: :league_managers
    get "claim", to: "claims#claim", as: :claim_school
    patch "claim", to: "claims#add_claim", as: :add_claim
    
    # errors
    get '/404', to: 'errors#not_found', as: :not_found
    get '/422' => 'errors#server_error'
    get '/500' => 'errors#server_error'
    
    post "setup/create_object" => "setup#create_object"

    get "/checkemail" => "users#email_check"
end
