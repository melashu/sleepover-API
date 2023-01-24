Rails.application.routes.draw do

  post '/auth/login/', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
      get 'rooms/reservation', to: 'rooms#checkout_reservation'
      get "reservation/history", to: 'reservation#history'
      resources :hotels
      resources :rooms
      resources :reservation

      resources :users
      end

  end
end
