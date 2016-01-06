Rails.application.routes.draw do
  root to: 'pages#welcome', constraints: RouteConstraints::NoUserRequiredConstraint.new, as: :nonauthenticated_root
  root to: 'pages#main', constraints: RouteConstraints::UserRequiredConstraint.new, as: :authenticated_root

  resources :users, only: [:new, :create]
  get '/sign_up', to: 'users#new', as: :sign_up

  resources :sessions, only: [:new, :create, :destroy]
  get '/sign_in', to: 'sessions#new', as: :sign_in
  delete '/sign_out', to: 'sessions#destroy', as: :sign_out
end
