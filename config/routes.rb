Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: { format: 'json' } do
    get '/users', to: 'users#index'
    post '/users/sign_in', to: 'users#signIn'
    post '/users/sign_up', to: 'users#signUp'
    delete '/users/delete', to: 'users#delete'
  end
end
