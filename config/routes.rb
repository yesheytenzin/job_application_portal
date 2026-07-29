# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, path: 'api/v1/auth',
    path_names: {
      sign_in: 'sign_in',
      sign_out: 'sign_out',
      registration: 'sign_up'
    },
    controllers: {
      sessions: 'api/v1/auth/sessions',
      registrations: 'api/v1/auth/registrations'
    }
  namespace :api do
    namespace :v1 do
      resource :profile, only: [ :show, :update ], controller: :profiles
      resources :jobs
    end
  end
end
