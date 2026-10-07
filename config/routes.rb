# config/routes.rb

Rails.application.routes.draw do
  devise_for :users,
    path: 'api/guard',
    path_names: {
      sign_in: 'sign_in',
      sign_out: 'sign_out',
      registration: 'sign_up'
    },
    controllers: {
      sessions: 'api/guard/sessions',
      registrations: 'api/guard/registrations'
    }

  namespace :api do
    namespace :shared do
      resource :profile,
        only: [ :show, :update ],
        controller: '/api/shared/profiles'
    end

    namespace :job do
      namespace :v1 do
        resources :jobs, only: [ :index, :show ], controller: '/api/job/v1/jobs'
      end
    end

    namespace :admin do
      namespace :v1 do
        resources :jobs, only: [ :create, :update, :destroy ], controller: '/api/admin/v1/jobs'
      end
    end
  end
end
