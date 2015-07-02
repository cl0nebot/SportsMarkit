Rails.application.routes.draw do
    root 'main#home'

    get "lockscreen" => "main#lockscreen"
    get "home" => "main#home"
    
    resources :users do
      get :email
      get :phone
      resources :photos
      post :add_school_team_at_setup
      delete :remove_school_team
      delete :remove_non_school_team
      delete :remove_coach_team
      delete :remove_child
      post :add_non_school_team_at_setup
      post :add_coach_team_at_setup
      post :add_athletic_director_at_setup
      post :add_child_at_setup
      resources :user_profile_pictures, only: %w[create update destroy]
      resources :events
      resource :calendar do
        get :events, on: :member
      end
      resources :measurables
      resources :certificates
      resources :media
    end
    
    get "testsetup" => "setup#testsetup", as: :test_setup
    get "/users/:id/setup" => "setup#setup", as: :user_setup
    get "/users/:id/overview" => "setup#overview", as: :user_overview
    patch "/user/:id/athlete_setup" => "setup#athlete_setup", as: :athlete_setup
    patch "/user/:id/coach_setup" => "setup#coach_setup", as: :coach_setup
    patch "/user/:id/athletic_director_setup" => "setup#athletic_director_setup", as: :athletic_director_setup

    get "welcome" => "users#welcome", as: :user_welcome

    resources :measurables
    resources :certificates
    resources :media
    resources :events
    resources :sessions
    resources :password_resets
    resources :schools do
      resources :facilities
      resources :media
      resources :teams
      resources :photos
      get :upgrade
      get :plan
      patch :upgrade_school
    end
    
    resources :teams do
      get :edit_roster_view
      get :close_roster_view
      resources :photos
      resources :events
      resources :media
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

    resources :facilities do
      resources :media
      resources :photos
    end

    resources :tournaments
    resources :leagues do
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
    resources :team_facilities
    resources :team_leagues
    resources :classifications
    resources :parent_children
    resources :approval do
      get "approval" => "approval#approval", as: :approval
      member do
        patch :approve_director
        patch :approve_coach
      end
    end
    
    get 'auth/:provider/callback', to: "omniauth_callbacks#facebook"
    get 'auth/failure', to: redirect('/')
    
    get "login" => "sessions#new", as: :login
    get "signup" => "users#new", as: :signup
    
    get "onboard", to: "claims#onboard", as: :partner_signup
    post "onboard", to: "claims#partner_initial_claim", as: :partner_signup_claim
    get "claim", to: "claims#claim", as: :claim_school
    patch "claim", to: "claims#add_claim", as: :add_claim
end
