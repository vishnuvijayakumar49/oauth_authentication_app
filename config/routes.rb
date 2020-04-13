Rails.application.routes.draw do

  use_doorkeeper

  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      scope :users do
        post 'reset_password' =>  'users#reset_password'
        get 'email' => 'users#check_mail'
      end

      resources :widgets
      resources :users do
        post 'password' => 'users#change_password'
        resources :widgets, only: [:index]
      end
    end
  end 

end
