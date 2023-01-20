Rails.application.routes.draw do

  post '/auth/login/', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
      resources :rooms
      # Put your route below 
      # 
      resources :users


    end
  end
end
