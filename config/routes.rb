Rails.application.routes.draw do
    root 'main#index'
    
    resources :users do
      get "setup" => "users#setup", as: :user_setup
      resources :events
      resource :calendar do
        get :events, on: :member
      end
      resources :measurables
    end
    get "welcome" => "users#welcome", as: :user_welcome

    resources :measurables
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
    resources :team_facilities
    resources :team_leagues
    resources :classifications
    resources :parent_children
    
    get 'auth/:provider/callback', to: "omniauth_callbacks#facebook"
    get 'auth/failure', to: redirect('/')
    
    get "login" => "sessions#new", as: :login
    get "signup" => "users#new", as: :signup
end
