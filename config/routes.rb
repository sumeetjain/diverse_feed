Rails.application.routes.draw do
  resource :profile, only: [:show, :update]
  resources :reports, only: [:new, :create, :show]

  delete "/logout", to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
end
