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
    namespace :admin do
      namespace :v1 do
        resources :jobs, only: %i[create update destroy], controller: '/api/admin/v1/jobs'

        resources :job_applications, only: %i[index show update destroy], controller: '/api/admin/v1/job_applications'
      end
    end

    namespace :user do
      namespace :v1 do
        resources :job_applications,
                  only: %i[index show create],
                  controller: '/api/user/v1/job_applications'

        resource :profile,
                 only: %i[show update],
                 controller: '/api/user/v1/profiles'

        resources :jobs,
                  only: %i[index show],
                  controller: '/api/user/v1/jobs'
      end
    end
  end
end
