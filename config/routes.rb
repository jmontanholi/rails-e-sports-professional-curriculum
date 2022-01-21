Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: { format: 'json' } do
    get '/users', to: 'users#index'
    post '/users/sign_in', to: 'users#sign_in'
    post '/users/sign_up', to: 'users#sign_up'
    delete '/users/delete', to: 'users#delete'

    post '/companies/sign_in', to: 'companies#sign_in'
    post '/companies/sign_up', to: 'companies#sign_up'
    delete '/companies/delete', to: 'companies#delete'

    post '/favorite/create', to: 'favorite_gamers#create'
    delete '/favorite/delete', to: 'favorite_gamers#delete'

    post '/photo/create', to: 'photos#create'
    delete '/photo/delete', to: 'photos#delete'

    post '/video/create', to: 'videos#create'
    delete '/video/delete', to: 'videos#delete'
  end
end
