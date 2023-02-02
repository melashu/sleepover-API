Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
 default_url_options host: 'localhost'
  post '/auth/login/', to: 'authentication#login'
  post '/auth/signup/', to: 'api/v1/users#create'

  namespace :api do
    namespace :v1 do
      get 'hotels/all', to: 'hotels#all_hotel'
      get 'rooms/reservations', to: 'rooms#checkout_reservation'
      get "reservations/history", to: 'reservations#history'
      get "reservations/all", to: 'reservations#all_reservation'

      resources :hotels
      resources :rooms
      resources :users, except: [:create]
      resources :reservations
    end
  end
end
