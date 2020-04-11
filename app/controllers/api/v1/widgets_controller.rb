module Api::V1
  class WidgetsController < ApiController
    # before_action -> { doorkeeper_authorize! :admin }, only: :index
    # doorkeeper_for :index, :scopes => [:public]

    def index
      binding.pry
      render json: Widget.all
    end

    def show
      render json: Widget.where(id: params[:id]), status: :ok
    end

    def me
      render json: current_resource_owner.to_json
    end

    private

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if current_resource_owner
    end
  end
end
