Rails.application.routes.draw do

  post '/auth/login/', to: 'authentication#login'
  post '/auth/signup/', to: 'api/v1/users#create'


  namespace :api do
    namespace :v1 do
      get 'rooms/reservation', to: 'rooms#checkout_reservation'

      resources :hotels
      resources :rooms

      resources :users, except: [:create]
      end
  end
end
