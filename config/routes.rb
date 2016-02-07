Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ru/ do
    root to: 'pages#welcome', constraints: RouteConstraints::NoUserRequiredConstraint.new, as: :nonauthenticated_root
    root to: 'results#index', constraints: RouteConstraints::UserRequiredConstraint.new, as: :authenticated_root

    resources :users, only: [:new, :create]
    get '/sign_up', to: 'users#new', as: :sign_up

    resources :sessions, only: [:new, :create, :destroy]
    get '/sign_in', to: 'sessions#new', as: :sign_in
    delete '/sign_out', to: 'sessions#destroy', as: :sign_out

    resources :acts, except: [:new, :edit, :show]
    resources :results, except: [:new, :edit, :show] do
      collection do
        get :data
      end
    end
  end
end
