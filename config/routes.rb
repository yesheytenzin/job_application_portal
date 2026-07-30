# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, path: 'api/guard',
    path_names: {
      sign_in: 'sign_in',
      sign_out: 'sign_out',
      registration: 'sign_up'
    },
    controllers: {
      sessions: 'api/guard/sessions',
      registrations: 'api/guard/registrations'
    }
end
