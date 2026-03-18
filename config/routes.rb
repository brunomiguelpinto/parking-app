Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resource :profile, only: [:edit, :update]
  resources :reservations, only: [:new, :create]

  namespace :admin do
    resources :parking_spots, except: [:show, :destroy] do
      member { patch :toggle }
    end
    resources :users, except: [:show, :destroy] do
      member { patch :toggle }
    end
    resources :reservations, only: [:index] do
      member do
        patch :approve
        patch :reject
      end
    end
  end

  root "dashboard#show"
end
