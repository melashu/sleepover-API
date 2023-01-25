Rails.application.routes.draw do

  get '/auth/login/', to: 'authentication#login'
  post '/auth/signup/', to: 'api/v1/users#create'

  namespace :api do
    namespace :v1 do
      get 'rooms/reservations', to: 'rooms#checkout_reservation'
      get "reservations/history", to: 'reservation#history'
      resources :hotels
      resources :rooms
      resources :users, except: [:create]
      resources :reservations
    end
  end
end
