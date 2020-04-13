module Api::V1
  class UsersController < ApiController
    include Response

    before_action :set_user, only: [:update, :show, :change_password]
    before_action do
      doorkeeper_authorize! :public, :read
    end

    def show
      render json: @user, status: :ok
      # render json: User.where(id: params[:id]), status: :ok
    end

    def update
      if @user.update(update_params)
        json_response(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def create
      user = User.new(user_params)
      if user.save
        json_response(user)
      else
        json_response(user, :unprocessable_entity)
      end
    end

    def reset_password
    
    end

    def check_mail
    end

    def change_password
      
    end

    private

    def user_params
      params(:user).permit(:first_name, :last_name, :password, :email, :image_url, :date_of_birth)
    end

    def update_params
      params(:user).permit(:first_name, :last_name, :image_url, :date_of_birth)
    end

    def set_user
      @user = (params[:id] == 'me') ? current_user : User.find(params[:id])
    end

  end
end

