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
        resources :job_applications, only: %i[ index show update destroy ], controller: '/api/admin/v1/job_applications'
      end
    end

    namespace :user do
      namespace :v1 do
        resources :job_applications, only: %i[ index show create ], controller: '/api/user/v1/job_applications'
      end
    end
  end
end
