Rails.application.routes.draw do

  use_doorkeeper

  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :widgets
      resources :users do
        post 'password' => 'users#change_password'
        resources :widgets, only: [:index]
      end

      scope :users do
        post 'reset_password' =>  'users#reset_password'
        get 'email' => 'users#check_mail'
      end
    end
  end 

end
