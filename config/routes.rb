Rails.application.routes.draw do
    root 'main#index'
    
    resources :users do
      resources :user_profile_pictures, only: %w[create update destroy]
      resources :events
      resource :calendar do
        get :events, on: :member
      end
      resources :measurables
      resources :certificates
      resources :media
    end
    
    get "/users/:id/setup" => "setup#setup", as: :user_setup
    get "/users/:id/overview" => "setup#overview", as: :user_overview
    patch "/user/:id/athlete_setup" => "setup#athlete_setup", as: :athlete_setup
    patch "/user/:id/coach_setup" => "setup#coach_setup", as: :coach_setup

    get "welcome" => "users#welcome", as: :user_welcome

    resources :measurables
    resources :certificates
    resources :media
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
        patch :reject_user
        post :add_facility
        post :create_roster_spot
        get :join_league
        get :leave_league
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
    resources :amenities
    resources :team_facilities
    resources :team_leagues
    resources :classifications
    resources :parent_children
    
    get 'auth/:provider/callback', to: "omniauth_callbacks#facebook"
    get 'auth/failure', to: redirect('/')
    
    get "login" => "sessions#new", as: :login
    get "signup" => "users#new", as: :signup
    
    get "partner/signup", to: "claims#partner_signup", as: :partner_signup
    post "partner/signup", to: "claims#partner_initial_claim", as: :partner_signup_claim
    get "claim", to: "claims#claim", as: :claim_school
    patch "claim", to: "claims#add_claim", as: :add_claim
end
