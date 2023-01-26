Rails.application.routes.draw do

  post '/auth/login/', to: 'authentication#login'
  post '/auth/signup/', to: 'api/v1/users#create'

  namespace :api do
    namespace :v1 do
      get 'rooms/reservation', to: 'rooms#checkout_reservation'
      get "reservations/history", to: 'reservation#history'
      get "reservations/all", to: 'reservation#all_reservation'

      resources :hotels
      resources :rooms
      resources :users, except: [:create]
      resources :reservations
    end
  end
end
