Rails.application.routes.draw do
  get 'homepage/show'

  resource :profile, only: [:show, :update]
  resources :reports, only: [:new, :create, :show]

  delete "/logout", to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login', to: redirect('/auth/twitter'), as: :login

  root to: 'homepage#show'
end
