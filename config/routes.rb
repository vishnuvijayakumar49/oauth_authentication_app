Rails.application.routes.draw do

  use_doorkeeper

  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :widgets
      resources :users do
        resources :widgets, only: [:index]
      end
    end
  end 

end
