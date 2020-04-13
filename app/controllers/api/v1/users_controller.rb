module Api::V1
  class UsersController < ApiController
    include Response

    before_action :set_user, only: [:update, :show, :change_password]
    before_action(except: [:reset_password]) do
      doorkeeper_authorize! :public, :read
    end

    def show
      render json: @user, status: :ok
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
      if email_exist?(reset_params[:email])
        msg = "Password reset email sent to #{reset_params[:email]}"
        render json: {data: {"message": msg}}, status: :ok
      else
        render json: {data: {"message": "No Record Found"}}, status: :ok
      end
    end

    def check_mail
      if email_exist?(params[:email])
        render json: {data: {"available": true}}, status: :ok
      else
        render json: {data: {"available": false}}, status: :ok
      end
    end

    def change_password
      args = {
              password: password_params[:current_password],
              password_confirmation: password_params[:new_password]
            }
      if @user.update(args)
        json_response(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params(:user).permit(:first_name, :last_name, :password, :email, :image_url, :date_of_birth)
    end

    def update_params
      params(:user).permit(:first_name, :last_name, :image_url, :date_of_birth)
    end

    def password_params
      params.require(:user).permit(:current_password, :new_password)
    end

    def reset_params
      params.require(:user).permit(:email)
    end

    def email_exist?(mail)
      User.where(email: mail).exists?
    end

    def set_user
      @user = (params[:user_id] == 'me') ? current_user : User.find(params[:id])
    end

  end
end

