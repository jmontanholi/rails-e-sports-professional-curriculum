Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: { format: 'json' } do
    get '/users', to: 'users#index'
    post '/users/sign_in', to: 'users#signIn'
    post '/users/sign_up', to: 'users#signUp'
    delete '/users/delete', to: 'users#delete'

    post '/companies/sign_in', to: 'companies#signIn'
    post '/companies/sign_up', to: 'companies#signUp'
    delete '/companies/delete', to: 'companies#delete'
  end
end
